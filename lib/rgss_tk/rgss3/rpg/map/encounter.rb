module RPG
  class Map
    class Encounter
      def initialize
        @troop_id = 1
        @weight = 10
        @region_set = []
      end

      # @return [Integer]
      attr_accessor :troop_id
      # @return [Integer]
      attr_accessor :weight
      # @return [Array<Integer>]
      attr_accessor :region_set
    end
  end
end
