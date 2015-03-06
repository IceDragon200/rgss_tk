require_relative '../../spec_helper'
require 'rgss_tk/rpg'
require 'rgss_tk/rpg-json'

describe RPG::Class::Learning do
  context "#to_json" do
    it "should convert object to JSON" do
      subject.to_json
    end
  end
end
