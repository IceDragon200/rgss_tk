require 'rgss_tk/rgss3/rpg/base_item'

module RPG
  class UsableItem < BaseItem
    class Damage
      def initialize
        @type = 0
        @element_id = 0
        @formula = '0'
        @variance = 20
        @critical = false
      end

      def none?
        @type == 0
      end

      def to_hp?
        [1,3,5].include?(@type)
      end

      def to_mp?
        [2,4,6].include?(@type)
      end

      def recover?
        [3,4].include?(@type)
      end

      def drain?
        [5,6].include?(@type)
      end

      def sign
        recover? ? -1 : 1
      end

      def eval(a, b, v)
        [Kernel.eval(@formula), 0].max * sign rescue 0
      end

      # @return [Integer]
      attr_accessor :type
      # @return [Integer]
      attr_accessor :element_id
      # @return [String]
      attr_accessor :formula
      # @return [Integer]
      attr_accessor :variance
      # @return [Boolean]
      attr_accessor :critical
    end
  end
end
