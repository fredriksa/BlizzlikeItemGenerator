require "singleton"

class GenerationData
    include Singleton

    attr_accessor :start_entry, :entry_modifier, :regeneration

    def initialize
        @start_entry = 0
        @entry_modifier = 0
        @regeneation = false
    end
end