module RPG
  class System
    class TestBattler
      def initialize
        @actor_id = 1
        @level = 1
        @equips = [0,0,0,0,0]
      end

      # @return [Integer]
      attr_accessor :actor_id
      # @return [Integer]
      attr_accessor :level
      # @return [Array<Integer>]
      attr_accessor :equips
    end
  end
end
