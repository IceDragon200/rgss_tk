require 'rgss_tk/core/null_out'

module RgssTk
  class BuilderBase
    attr_reader :list
    attr_accessor :debug

    def initialize
      @list = []
      @debug = NullOut.new
    end

    def _eval(data = nil, filename = nil, &block)
      if block_given?
        instance_eval(&block)
      else
        instance_eval(data, filename, 1)
      end
      self
    end

    def empty?
      @list.empty?
    end

    def render
      @list
    end

    def clear
      @list.clear
    end

    def partial
      old_list = @list
      @list = []
      yield
      new_list = @list
      @list = old_list
      new_list
    end

    def concat(objs)
      @list.concat(objs)
    end

    def push(*objs)
      concat(objs)
    end

    def append(other)
      other.each do |cmd|
        new_cmd = cmd.dup
        new_cmd.indent += @indent
        push new_cmd
      end
    end

    def self.render(data, filename = 'render')
      builder = new
      builder._eval(data, filename).render
    end

    def self.render_file(filename)
      render(File.read(filename), filename)
    end
  end
end
