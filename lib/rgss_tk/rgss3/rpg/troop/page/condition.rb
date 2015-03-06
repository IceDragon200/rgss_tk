module RPG
  class Troop
    class Page
      class Condition
        def initialize
          @turn_ending = false
          @turn_valid = false
          @enemy_valid = false
          @actor_valid = false
          @switch_valid = false
          @turn_a = 0
          @turn_b = 0
          @enemy_index = 0
          @enemy_hp = 50
          @actor_id = 1
          @actor_hp = 50
          @switch_id = 1
        end

        # @return [Boolean]
        attr_accessor :turn_ending
        # @return [Boolean]
        attr_accessor :turn_valid
        # @return [Boolean]
        attr_accessor :enemy_valid
        # @return [Boolean]
        attr_accessor :actor_valid
        # @return [Boolean]
        attr_accessor :switch_valid
        # @return [Integer]
        attr_accessor :turn_a
        # @return [Integer]
        attr_accessor :turn_b
        # @return [Integer]
        attr_accessor :enemy_index
        # @return [Integer]
        attr_accessor :enemy_hp
        # @return [Integer]
        attr_accessor :actor_id
        # @return [Integer]
        attr_accessor :actor_hp
        # @return [Integer]
        attr_accessor :switch_id
      end
    end
  end
end
