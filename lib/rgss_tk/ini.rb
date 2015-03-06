module Ini
  def self.parse(str)
    result = {}
    section = nil
    str.each_line do |line|
      line = line.gsub(/(;.*)/, '')
      if line =~ /\[(.+)\]/
        section = $1
      elsif line =~ /(\S+)\s*=\s*(.*)/
        key = $1
        src = $2
        value = case src
                when ""
                   nil
                when /\A(\d+.\d+)\z/
                  src.to_f
                when /\A(\d+)%\z/
                  src.to_i / 100.0
                when /\A(\d+)\z/
                  src.to_i
                else
                  src
                end
        (result[section] ||= {})[key] = value
      end
    end
    result
  end

  def self.dump(object)
    object.to_ini
  end

  class << self
    alias :load :parse
  end

  def self.load_file(filename)
    File.open filename, "r" do |io|
      return parse(io.read)
    end
  end
end

class Hash
  def to_ini
    result = ""
    each do |key, value|
      case value
      when Hash
        result << "[#{key}]\n"
        value.each do |k, v|
          s = case v
              when Array
                v.join(",")
              when String
                v
              when Numeric
                v.inspect
              when nil, false
                "No"
              when true
                "Yes"
              else
                raise TypeError
              end
          result << "#{k}=#{s}\n"
        end
      end
    end
    result
  end
end
