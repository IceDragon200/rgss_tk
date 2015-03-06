require 'rgss_tk/rgss3/rpg/troop/page/condition'

module RPG
  class Troop
    class Page
      def initialize
        @condition = RPG::Troop::Page::Condition.new
        @span = 0
        @list = [RPG::EventCommand.new]
      end

      # @return [RPG::Troop::Page::Condition]
      attr_accessor :condition
      # @return [Integer]
      attr_accessor :span
      # @return [Array<RPG::EventCommand>]
      attr_accessor :list
    end
  end
end
