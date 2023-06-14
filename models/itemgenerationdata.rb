class ItemGenerationData
    include DataMapper::Resource

    property :id, Serial
    property :item_entry, Integer
    property :class_id, Integer
    property :subclass_id, Integer
    property :ilevel, Integer
    property :level, Integer
    property :bonding, Integer
    property :display_id, Integer

    # STATS (including rstats)
    property :stat1, String 
    property :allocatedStat1, Float

    property :stat2, String 
    property :allocatedStat2, Float

    property :stat3, String 
    property :allocatedStat3, Float

    property :stat4, String 
    property :allocatedStat4, Float

    property :stat5, String 
    property :allocatedStat5, Float

    property :stat6, String 
    property :allocatedStat6, Float

    property :stat7, String 
    property :allocatedStat7, Float

    property :stat8, String 
    property :allocatedStat8, Float

    property :stat9, String 
    property :allocatedStat9, Float

    property :stat10, String 
    property :allocatedStat10, Float

    property :stat11, String 
    property :allocatedStat11, Float
end