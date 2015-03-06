require 'zlib'

module Rvdata
  def self.load(data)
    Marshal.load(data)
  end

  def self.dump(obj)
    Marshal.dump(obj)
  end

  def self.load_file(filename)
    File.open(filename, "rb") do |file|
      return load(file)
    end
  end

  def self.save_file(filename, obj)
    File.open(filename, "wb") do |file|
      file.write(dump(obj))
    end
  end

  def self.inflate_scripts(data)
    data.map do |(checksum, name, content)|
      [checksum, name, Zlib.inflate(content)]
    end
  end

  def self.load_scripts(data)
    load(inflate_scripts(data))
  end

  def self.load_scripts_file(filename)
    inflate_scripts(load_file(filename))
  end

  def self.deflate_scripts(data)
    data.map do |(checksum, name, content)|
      [checksum, name, Zlib.deflate(content)]
    end
  end

  def self.dump_scripts(data)
    dump(deflate_scripts(data))
  end

  def self.save_scripts_file(filename, data)
    save_file(filename, deflate_scripts(data))
  end
end

Rvdata2 = Rvdata
