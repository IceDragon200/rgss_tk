require_relative '../spec_helper.rb'
require 'rgss_tk/rpg'
require 'rgss_tk/rpg-json'

describe RPG::UsableItem do
  context "#to_json" do
    it "should convert object to JSON" do
      subject.to_json
    end
  end
end
