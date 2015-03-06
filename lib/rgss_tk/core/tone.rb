class Tone
  attr_reader :red
  attr_reader :green
  attr_reader :blue
  attr_reader :gray

  def initialize(*args)
    set(*args)
  end

  def set(*args)
    case args.size
    when 0
      r,g,b,a=0,0,0,0
    when 1 # Tone
      arg, = *args
      r,g,b,a = *arg
    when 3,4 # r, g, b [, a]
      r,g,b,a = *args
      a||=0
    else
      raise ArgumentError,
            "wrong argument count #{args.size} (expected 0, 1, 3 or 4)"
    end
    @red, @green, @blue, @gray = r, g, b, a
  end

  def red=(n)
    @red = [[-255, n].max, 255].min
  end

  def green=(n)
    @green = [[-255, n].max, 255].min
  end

  def blue=(n)
    @blue = [[-255, n].max, 255].min
  end

  def gray=(n)
    @gray = [[-255, n].max, 255].min
  end

  def to_a
    return @red, @green, @blue, @gray
  end

  def _dump(depth)
    to_a.pack("D4")
  end

  def self._load(str, depth=0)
    new(*str.unpack("D4"))
  end
end
