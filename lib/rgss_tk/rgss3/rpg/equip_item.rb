require 'rgss_tk/rgss3/rpg/base_item'

module RPG
  class EquipItem < BaseItem
    def initialize
      super
      @price = 0
      @etype_id = 0
      @params = Array.new(8, 0)
    end
    attr_accessor :price
    attr_accessor :etype_id
    attr_accessor :params
  end
end
