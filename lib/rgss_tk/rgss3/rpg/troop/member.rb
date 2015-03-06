module RPG
  class Troop
    class Member
      def initialize
        @enemy_id = 1
        @x = 0
        @y = 0
        @hidden = false
      end

      # @return [Integer]
      attr_accessor :enemy_id
      # @return [Integer]
      attr_accessor :x
      # @return [Integer]
      attr_accessor :y
      # @return [Boolean]
      attr_accessor :hidden
    end
  end
end
