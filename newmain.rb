require_relative "./lib/itemgenerator.rb"

require_relative "./lib/armorgenerator.rb"
require_relative "./lib/attackspeedgenerator.rb"
require_relative "./lib/damagegenerator.rb"
require_relative "./lib/displayselector.rb"
require_relative "./lib/dpsgenerator.rb"
require_relative "./lib/durabilitygenerator.rb"
require_relative "./lib/errorchecker.rb"
require_relative "./lib/item.rb"
require_relative "./lib/itemlevel.rb"
require_relative "./lib/itemtoken.rb"
require_relative "./lib/itemtokengenerator.rb"
require_relative "./lib/namegenerator.rb"
require_relative "./lib/pricegenerator.rb"
require_relative "./lib/qualitybudget.rb"
require_relative "./lib/slotbudget.rb"
require_relative "./lib/statsformatter.rb"
require_relative "./lib/statsgenerator.rb"
require_relative "./lib/string.rb"

# Use bundler to load gems
require 'bundler'

# Load gems from Gemfile
Bundler.require

# Load settings for development/production/test environments
require_relative 'config/environment'

require_relative "./models/bond.rb"
require_relative "./models/display.rb"
require_relative "./models/generator.rb"
require_relative "./models/mainclass.rb"
require_relative "./models/quality.rb"
require_relative "./models/rank.rb"
require_relative "./models/slot.rb"
require_relative "./models/stat.rb"
require_relative "./models/subclass.rb"

class ItemSetGenerator
    def self.generate(params)
      files = []
        
      slots = ["Head"]
      #slots = ["Head", ["Neck", "Neck"], "Shoulder", ["Back", "Cloth"], "Chest", "Waist", "Legs", "Feet", "Wrist", "Hands",
      #        ["Finger", "Finger"], ["Trinket", "Trinket"]] #Slots that will be generated
      #We have to manually enter the subclass for neck, back, finger and trinket
      entry_modifier = 0
      params['token_loot_distance_start'] = 0
  
      slots.each do |slot|
        # We need to handle wearables that are not of type Cloth, Leather etc..
        if slot.is_a? Array 
            params['slot'] = slot[0]
            params['subclass'] = slot[1]
        else
            params['slot'] = slot
            params['subclass'] = params['subclass']
        end
  
        files << ItemGenerator.generate(params, nil, entry_modifier)
        entry_modifier += params['amount'].to_i
  
        # If we have generated items for one slot we have to make room for possible crate item
        entry_modifier += 1
  
        # We have to keep track on what the next token ID should be
        params['next_item_token_id'] = params['id'].to_i + entry_modifier + params['amount'].to_i
        # We have to keep track on how far away from 'start position' we are 
        params['token_loot_distance_start'] += params['amount'].to_i + 1
      end
  
      filename = "./sql/merged_itemset.sql"
  
      files.each do |file|
        merge_sql(file, filename)
      end
  
      return filename
    end
  
    def self.merge_sql(file, target_file)
      file = File.open(file, 'r')
  
      if File.exists? target_file
        target_file = File.open(target_file, 'a')
      else
        target_file = File.open(target_file, 'w')
      end
      
      file_lines = file.readlines
  
      file_lines.each do |line|
        target_file.puts line
      end
  
      file.close
      target_file.close
    end
  end

require_relative "./src/itemsets.rb"

puts(ITEM_SETS)

params = {}

# Default Params
params["id"] = 90000 # Starting-ID for this batch's generated items.
params["amount"] = 1 # Number of variations
params["crate"] = "no" # no/yes - Item crate yes or no?
params["unavailable"] = 0.5 # Unavailable percentage
params["suffix"] = false # false/true
params["ilevel"] = 0 # ilevel modifier
params["level"] = 1 # level requirement
params["displaylevel"] = 1 # Display level
params["staticitemlevel"] = "No" # Yes/No - capitalization important
params["bonding"] = "Bind on equip" # No bound/Bind on pickup/Bind on equip/Bind on use
params["quality"] = "Uncommon" # Uncommon/Rare/Epic/Legendary

params["level"] = 60 # level requirement
params["displaylevel"] = 60 # Display level

ITEM_SETS.each do |key, inner_map|
    puts "Key: #{key}"
    params_dup = params.dup

    puts "Key: #{key}"
  
    inner_map.each do |nested_key, value|
      puts "Nested Key: #{nested_key}, Value: #{value}"
    end

    params_dup["subclass"] = inner_map["subclass"]
    print("Subclass #{params_dup["subclass"]}")

    rstatCount = 0
    ["rstat1", "rstat2", "rstat3", "rstat4", "rstat5", "rstat6", "rstat7"].each do |item|
        puts item

        if inner_map.key?(item)
            rstatCount += 1
            params_dup[item] = inner_map[item]
        end
    end

    params_dup["minrstats"] = 0
    params_dup["maxrstats"] = 2 

    ["stat1", "stat2", "stat3", "stat4", "stat5", "stat6", "stat7"].each do |item|
        puts item

        if inner_map.key?(item)
            params_dup[item] = inner_map[item]
        end
    end

    ItemSetGenerator.generate(params_dup)
end

# params["subclass"] = "Cloth" # Cloth/LeatherMail/Plate

# params["stat1"] = "Agility" # Stat nr 1. Up to stat9 inclusive exists.
# params["stat2"] = "Stamina"
# params["rstat1"] = "Healing" # Random stat nr 1. Up to rstat 9 inclusive exists.
# params["rstat2"] = "Crit" 

# params["minrstats"] = 1
# params["maxrstats"] = 2

#ItemSetGenerator.generate(params)

exit!