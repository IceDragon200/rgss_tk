require_relative '../spec_helper.rb'
require 'rgss_tk/rpg'
require 'rgss_tk/rpg-json'

describe RPG::Map do
  context "#to_json" do
    it "should convert object to JSON" do
      RPG::Map.new(17, 15).to_json
    end
  end
end
