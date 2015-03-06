class Manufacturer
  attr_accessor :name
end

class Bread
  attr_accessor :slices
  attr_accessor :buttered
  attr_accessor :size
  attr_accessor :wheat_flavoured
  attr_accessor :manufacturer
end

bread = Bread.new.options_set(slices: 2, buttered: false, size: "xl", wheat_flavoured: false, manufacturer: Manufacturer.new)
bread.options_set('manufacturer.name' => 'Ice Corp')
p bread
