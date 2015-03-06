class Rect
  attr_reader :x
  attr_reader :y
  attr_reader :width
  attr_reader :height

  def initialize(*args)
    set(*args)
  end

  def empty
    @x, @y, @width, @height = 0, 0, 0, 0
    self
  end

  def empty?
    @width == 0 || @height == 0
  end

  def to_a
    return @x, @y, @width, @height
  end

  def set(*args)
    case args.size
    when 0
      self.x, self.y, self.width, self.height = 0, 0, 0, 0
    when 1
      rect = args.first
      self.x, self.y, self.width, self.height = *rect
    when 4
      self.x, self.y, self.width, self.height = *args
    end
    self
  end

  def x=(x)
    @x = x.to_i
  end

  def y=(y)
    @y = y.to_i
  end

  def width=(width)
    @width = width.to_i
  end

  def height=(height)
    @height = height.to_i
  end

  def _dump(depth)
    [@x, @y, @width, @height].pack("l4")
  end

  def self._load(str, depth=0)
    new(*str.unpack("l4"))
  end
end
