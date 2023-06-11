class WeaponGenerator
  #generates weapon from selected params
  def self.generate(params, user_id = nil)
    weapons = []
    weapons_to_create = params['amount'].to_i
    weapons_to_create.times do
      weapons << generate_weapon(params)
      GenerationData.instance.entry_modifier += 1
    end
    
    filename = "./sql/merged_weapons_"
    
    unless user_id.nil?
      filename += "#{user_id}_"
    end

    filename += "#{weapons.first.slot_id}_#{weapons.first.subclass_id}.sql"
    self.save_sql(weapons, filename, params)
    return filename
  end

  private
  def self.generate_weapon(params)
    StatsGenerator.set_unavailable_rate params['unavailable'].to_f

    weapon = Weapon.new
    weapon.entry = GenerationData.instance.start_entry + GenerationData.instance.entry_modifier
    weapon.level = params['level'].to_i
    weapon.class = :weapon
    weapon.subclass = params['subclass'].to_sym
    weapon.quality = params['quality'].to_sym
    weapon.slot = params['slot'].to_sym
    weapon.display_id = Displayselector.select(params, false)
    weapon.bonding = params['bonding'].to_sym
    weapon.itemlevel = ItemLevel.calculate(params)
    weapon.sellprice = PriceGenerator.sell_price(weapon, false)
    weapon.buyprice = PriceGenerator.buy_price(weapon, false)
    weapon.durability = DurabilityGenerator.generate(weapon)

    weapon.dps = DPSGenerator.generate(weapon)
    weapon.attackspeed = AttackspeedGenerator.generate(weapon)
    weapon.min_damage = DamageGenerator.generate_min(weapon)
    weapon.max_damage = DamageGenerator.generate_max(weapon)

    apply_level_modifier(weapon)

    weapon.stats = StatsGenerator.generate(weapon, StatsFormatter.format_array(params))
    weapon.name = NameGenerator.generate(weapon, params['suffix'] == 'true', true)
    return weapon
  end

  def self.apply_level_modifier(weapon)
      # Apply modifier depending on where in the world the level target is.
      # Classic items are weaker (<= 60), TBC are stronger (61-70), WOTLK is what the generator is implemented for. 
      pointModifier = 1
      if weapon.level <= 60
        pointModifier = 0.85 
      elsif weapon.level > 60 and weapon.level <= 70
        pointModifier = 0.95
      elsif weapon.level > 70 and weapon.level >= 80
        pointModifier = 1
      end
      
      weapon.min_damage *= pointModifier
      weapon.max_damage *= pointModifier
  end

  def self.save_sql(weapons, filename, params)
    file = File.open(filename, 'w')

    weapons.each do |weapon|
      file.puts weapon.generate_query
    end

    file.close
    WeaponTokenGenerator.generate(params, filename) if params['crate'] == 'yes'
  end
end