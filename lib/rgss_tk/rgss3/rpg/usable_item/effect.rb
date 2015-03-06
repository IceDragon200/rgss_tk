require 'rgss_tk/rgss3/rpg/base_item'

module RPG
  class UsableItem < BaseItem
    class Effect
      def initialize(code = 0, data_id = 0, value1 = 0, value2 = 0)
        @code = code
        @data_id = data_id
        @value1 = value1
        @value2 = value2
      end

      # @return [Integer]
      attr_accessor :code
      # @return [Integer]
      attr_accessor :data_id
      # @return [Integer]
      attr_accessor :value1
      # @return [Integer]
      attr_accessor :value2
    end
  end
end
