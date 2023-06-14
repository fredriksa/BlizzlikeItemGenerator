class Item
  attr_accessor :stats, :slot, :quality, :itemlevel, :name, 
                :level, :subclass, :armor, :entry, :class, :sheath,
                :display_id, :sellprice, :buyprice, :bonding, :durability, :bonding

  # Accessors for re-generation
  attr_accessor :distribution_map

  @@classes = {armor: 4}
  
  def generate_query
    query = "INSERT INTO `item_template` (`entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`, `displayid`, `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `StatsCount`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`, `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `flagsCustom`, `VerifiedBuild`) VALUES (" +
    "#{self.entry}, #{class_id}, #{subclass_id}, -1, " + '"' + self.name + '"' + ", #{self.display_id}, #{quality_id}, 0, 0, 1, #{self.buyprice}, #{self.sellprice}, #{slot_id}, -1, -1, #{self.itemlevel}, " +
    "#{self.level}, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, #{self.stats.size}, " + stat_string + " 0, 0, 0, 0, 0, 0, 0, 0, #{self.armor}, 0, 0, 0, 0, 0, 0, 0, 0, " +
    "0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, #{bonding_id}, "+
    "'', 0, 0, 0, 0, 0, 8, #{sheath}, 0, 0, 0, 0, #{self.durability}, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, #{self.durability}, 0, 0, 0, 0, '', 0, 0, 0, 0, 0, 12340);"
    saveItemGenerationData()
    query
  end

  def saveItemGenerationData
    statsKeys = self.stats.keys

    itemGenData = ItemGenerationData.create(
      item_entry: self.entry, 
      class_id: self.class,
      subclass_id: self.subclass, 
      level: self.level,
      bonding: bonding_id,
      display_id: self.display_id
    )

    # WARNING: For some reason this does not write to the SQLite database.
    itemGenData.save!
    
    #stat1: self.stats.size > 0 ? statsKeys[0].to_s : "",
    #  allocatedStat1: self.stats.size > 0 ? distribution_map[statsKeys[0]] : 0


    if self.stats.size > 1
      itemGenData.stat2 = statsKeys[1].to_s
      itemGenData.allocatedStat2 = distribution_map[statsKeys[1]]
    end

    if self.stats.size > 2
      itemGenData.stat3 = statsKeys[2].to_s
      itemGenData.allocatedStat3 = distribution_map[statsKeys[2]]
    end

    if self.stats.size > 3
      itemGenData.stat4 = statsKeys[3].to_s
      itemGenData.allocatedStat4 = distribution_map[statsKeys[3]]
    end

    if self.stats.size > 4
      itemGenData.stat5 = statsKeys[4].to_s
      itemGenData.allocatedStat5 = distribution_map[statsKeys[4]]
    end

    if self.stats.size > 5
      itemGenData.stat6 = statsKeys[5].to_s
      itemGenData.allocatedStat6 = distribution_map[statsKeys[5]]
    end

    if self.stats.size > 6
      itemGenData.stat7 = statsKeys[6].to_s
      itemGenData.allocatedStat7 = distribution_map[statsKeys[6]]
    end

    if self.stats.size > 7
      itemGenData.stat8 = statsKeys[6].to_s
      itemGenData.allocatedStat8 = distribution_map[statsKeys[7]]
    end

    if self.stats.size > 8
      itemGenData.stat9 = statsKeys[6].to_s
      itemGenData.allocatedStat9 = distribution_map[statsKeys[8]]
    end

    if self.stats.size > 9
      itemGenData.stat10 = statsKeys[6].to_s
      itemGenData.allocatedStat10 = distribution_map[statsKeys[9]]
    end

    if self.stats.size > 10
      itemGenData.stat11 = statsKeys[6].to_s
      itemGenData.allocatedStat11 = distribution_map[statsKeys[10]]
    end
  end

  # Returns the sheath value
  def sheath
    Subclass.first(name: @subclass).sheath
  end

  def self.class_id(clas)
    @@classes[clas]
  end

  # Returns the item instance's subclass in DB id form
  def self.subclass_id(subclass)
    Subclass.first(name: subclass).db_id
  end

  # Returns the slot's DB id
  def self.quality_id(quality)
    Quality.first(name: quality).db_id
  end

  # Returns the slot's DB id
  def self.slot_id(slot)
    # Incomplete list
    Slot.first(name: slot).db_id
  end

  # Returns the stat's DB id
  def self.stat_id(stat)
    Stat.first(name: stat).db_id
  end

  # Returns the slot's DB id
  def slot_id
    Slot.first(name: @slot).db_id
  end

  private
  # Returns the class id
  def class_id
    @@classes[self.class]
  end

  # Returns the item instance's subclass in DB id form
  def subclass_id
    Subclass.first(name: @subclass).db_id
  end

  # Returns the slot's DB id
  def quality_id
    Quality.first(name: @quality).db_id
  end

  # Returns the bonding ID
  def bonding_id
    Bond.first(name: self.bonding).db_id
  end

  # Returns the stat's DB id
  def stat_id(stat)
    Stat.first(name: stat).db_id
  end

  # Returns a built string for stat_type & stat_value
  def stat_string   
    total_pairs = 10

    string = ""
    self.stats.each do |key, value|
      string = string + "#{stat_id(key)}, #{value}, "
    end

    # Add the extra entries to the DB string we have not modified 
    current_pairs = self.stats.size
    left_pairs = total_pairs - current_pairs

    left_pairs.times do 
      string = string + "0, 0, "
    end

    string
  end
end