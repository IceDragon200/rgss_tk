module RPG
  class System
    class Vehicle
      def initialize
        @character_name = ''
        @character_index = 0
        @bgm = RPG::BGM.new
        @start_map_id = 0
        @start_x = 0
        @start_y = 0
      end

      # @return [String]
      attr_accessor :character_name
      # @return [Integer]
      attr_accessor :character_index
      # @return [RPG::BGM]
      attr_accessor :bgm
      # @return [Integer]
      attr_accessor :start_map_id
      # @return [Integer]
      attr_accessor :start_x
      # @return [Integer]
      attr_accessor :start_y
    end
  end
end
