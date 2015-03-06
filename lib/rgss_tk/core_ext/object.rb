class Object

  ###
  # Sets instance attributes using the hash key/value pairs
  #
  # @param [Hash] hash
  # @return [self]
  ###
  def options_set(hash)
    hash.each do |key, value|
      unroll = key.to_s.split(".")
      last_key = unroll.pop
      obj = unroll.inject(self) { |obj, key| obj.send(key) }
      obj.send("#{last_key}=", value)
    end
    self
  end

end
