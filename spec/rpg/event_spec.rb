require_relative '../spec_helper.rb'
require 'rgss_tk/rpg'
require 'rgss_tk/rpg-json'

describe RPG::Event do
  context "#to_json" do
    it "should convert object to JSON" do
      RPG::Event.new(0, 0).to_json
    end
  end
end
