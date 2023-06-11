require "singleton"

class GenerationData
    include Singleton

    attr_accessor :start_entry, :entry_modifier

    def initialize
        @start_entry = 0
        @entry_modifier = 0
    end
end