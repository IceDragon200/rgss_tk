module RPG
  class EventCommand
    def initialize(code = 0, indent = 0, parameters = [])
      @code = code
      @indent = indent
      @parameters = parameters
    end
    attr_accessor :code       # Integer
    attr_accessor :indent     # Integer
    attr_accessor :parameters # Array
  end
end
