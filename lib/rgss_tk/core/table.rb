class Table
  attr_reader :dimensions
  attr_reader :xsize
  attr_reader :ysize
  attr_reader :zsize
  attr_reader :size
  attr_accessor :data

  def initialize(*args)
    resize(*args)
  end

  def alloc_data
    @data = Array.new(@size, 0)
  end

  def resize(*args)
    @xsize, @ysize, @zsize = 1, 1, 1
    case args.size
    when 1
      @xsize = args.first
      @size = @xsize
      @dimensions = 1
    when 2
      @xsize, @ysize = *args
      @size = @xsize * @ysize
      @dimensions = 2
    when 3
      @xsize, @ysize, @zsize = *args
      @size = @xsize * @ysize * @zsize
      @dimensions = 3
    else
      raise ArgumentError,
            "wrong argument count #{args.size} (expected 1, 2, or 3)"
    end
    alloc_data
  end

  def [](*args)
    case @dimensions
    when 1
      raise ArgumentError,
            "wrong argument count #{args.size} (expected 1)" if args.size != 1
      x = args.first
      return 0 if x < 0 ||
                  @xsize < x
      @data[x]
    when 2
      raise ArgumentError,
            "wrong argument count #{args.size} (expected 2)" if args.size != 2
      x, y = *args
      return 0 if x < 0 ||
                  @xsize < x
      return 0 if y < 0 ||
                  @ysize < y
      @data[x + y * xsize]
    when 3
      raise ArgumentError,
            "wrong argument count #{args.size} (expected 3)" if args.size != 3
      x, y, z = *args
      return 0 if x < 0 ||
                  @xsize < x
      return 0 if y < 0 ||
                  @ysize < y
      return 0 if z < 0 ||
                  @zsize < z
      @data[x + y * @xsize + z * @xsize * @ysize]
    end
  end

  def []=(*args)
    case @dimensions
    when 1
      raise ArgumentError,
            "wrong argument count #{args.size} (expected 2)" if args.size != 2
      x, v = *args
      return if x < 0 ||
                @xsize < x
      @data[x] = v.to_i
    when 2
      raise ArgumentError,
            "wrong argument count #{args.size} (expected 3)" if args.size != 3
      x, y, v = *args
      return if x < 0 ||
                @xsize < x
      return if y < 0 ||
                @ysize < y
      @data[x + y * @xsize] = v.to_i
    when 3
      raise ArgumentError,
            "wrong argument count #{args.size} (expected 4)" if args.size != 4
      x, y, z, v = *args
      return if x < 0 ||
                @xsize < x
      return if y < 0 ||
                @ysize < y
      return if z < 0 ||
                @zsize < z
      @data[x + y * @xsize + z * @xsize * @ysize] = v.to_i
    end
  end

  def _dump(depth)
    [@dimensions, @xsize, @ysize, @zsize, @size].pack("L5") << @data.pack("s*")
  end

  def self._load(str, depth=0)
    data = str.unpack("L5s*")
    header = data[0, 5]
    dimensions, xsize, ysize, zsize, size = *header
    data = data[5...data.size]
    table = new(*([xsize, ysize, zsize][0,dimensions]))
    table.send(:data=, data)
    return table
  end

  private :alloc_data
  private :dimensions
  private :data=
  private :data
end
