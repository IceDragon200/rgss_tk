require 'rgss_tk/rgss3/rpg/base_item'

module RPG
  class Enemy < BaseItem
    class DropItem
      def initialize
        @kind = 0
        @data_id = 1
        @denominator = 1
      end
      attr_accessor :kind
      attr_accessor :data_id
      attr_accessor :denominator
    end
  end
end
