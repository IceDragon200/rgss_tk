class Color
  attr_reader :red
  attr_reader :green
  attr_reader :blue
  attr_reader :alpha

  def initialize(*args)
    set(*args)
  end

  def set(*args)
    case args.size
    when 0
      r,g,b,a=255,255,255,255
    when 1 # Color
      arg, = *args
      r,g,b,a = *arg
    when 3,4 # r, g, b [, a]
      r,g,b,a = *args
      a||=255
    else
      raise ArgumentError,
            "wrong argument count #{args.size} (expected 0, 1, 3 or 4)"
    end
    @red, @green, @blue, @alpha = r, g, b, a
  end

  def red=(n)
    @red = [[0, n].max, 255].min
  end

  def green=(n)
    @green = [[0, n].max, 255].min
  end

  def blue=(n)
    @blue = [[0, n].max, 255].min
  end

  def alpha=(n)
    @alpha = [[0, n].max, 255].min
  end

  def to_a
    return @red, @green, @blue, @alpha
  end

  def _dump(depth)
    to_a.pack('D4')
  end

  def self._load(str, depth = 0)
    new(*str.unpack('D4'))
  end
end
