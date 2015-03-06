require 'rgss_tk/rgss3/rpg/event/page/condition'
require 'rgss_tk/rgss3/rpg/event/page/graphic'
require 'rgss_tk/rgss3/rpg/event_command'
require 'rgss_tk/rgss3/rpg/move_route'

module RPG
  class Event
    class Page
      def initialize
        @condition = RPG::Event::Page::Condition.new
        @graphic = RPG::Event::Page::Graphic.new
        @move_type = 0
        @move_speed = 3
        @move_frequency = 3
        @move_route = RPG::MoveRoute.new
        @walk_anime = true
        @step_anime = false
        @direction_fix = false
        @through = false
        @priority_type = 0
        @trigger = 0
        @list = [RPG::EventCommand.new]
      end

      # @return [RPG::Event::Page::Condition]
      attr_accessor :condition
      # @return [RPG::Event::Page::Graphic]
      attr_accessor :graphic
      # @return [Integer]
      attr_accessor :move_type
      # @return [Integer]
      attr_accessor :move_speed
      # @return [Integer]
      attr_accessor :move_frequency
      # @return [RPG::MoveRoute]
      attr_accessor :move_route
      # @return [Boolean]
      attr_accessor :walk_anime
      # @return [Boolean]
      attr_accessor :step_anime
      # @return [Boolean]
      attr_accessor :direction_fix
      # @return [Boolean]
      attr_accessor :through
      # @return [Integer]
      attr_accessor :priority_type
      # @return [Integer]
      attr_accessor :trigger
      # @return [Array<RPG::EventCommand>]
      attr_accessor :list
    end
  end
end
