require 'rgss_tk/core_ext/object'
require 'rgss_tk/core_ext/kernel'
require 'active_support/inflector'

module RgssTk
  class Database
    class Builder
      attr_reader :list

      def initialize(klass)
        @klass = klass
        @list = []
        pad
      end

      def pad
        @list << nil
      end

      def create(*args)
        obj = @klass.new(*args)
        obj.id = @list.size
        yield obj if block_given?
        @list << obj
        obj
      end

      def save_data(filename)
        Kernel::save_data(@list, filename)
      end

    end

    def create_builder(klass)
      builder = Builder.new klass
      yield builder
      builder
    end

    [:actor, :class, :skill, :item, :weapon, :armor,
     :enemy, :troop, :state, :animation, :tileset, :common_event].each do |s|
      define_method "create_#{s.to_s.pluralize}" do |&block|
        require "rgss_tk/rgss3/rpg/#{s}"
        create_builder RPG.const_get(s.to_s.camelcase), &block
      end
    end

    def create_system
      require 'rgss_tk/rgss3/rpg/system'
      sys = RPG::System.new
      yield sys if block_given?
      sys
    end
  end
end
