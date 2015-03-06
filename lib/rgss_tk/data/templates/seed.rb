#
# rgss_tk/templates/seed.rb
#   by IceDragon
# rv 1.1.0
require "fileutils"
require "rgss_tk/rpg"
require "rgss_tk/db/seed/dsl"

include RgssTk::Database::DSL

dirname = "Data"
FileUtils::Verbose.mkdir_p(dirname)

db do |d|

  d.create_actors do |b|
    #
  end.save_data File.join(dirname, "Actors.rvdata2")

  d.create_classes do |b|
    #
  end.save_data File.join(dirname, "Classes.rvdata2")

  d.create_skills do |b|
    #
  end.save_data File.join(dirname, "Skills.rvdata2")

  d.create_items do |b|
    #
  end.save_data File.join(dirname, "Items.rvdata2")

  d.create_weapons do |b|
    #
  end.save_data File.join(dirname, "Weapons.rvdata2")

  d.create_armors do |b|
    #
  end.save_data File.join(dirname, "Armors.rvdata2")

  d.create_enemies do |b|
    #
  end.save_data File.join(dirname, "Enemies.rvdata2")

  d.create_troops do |b|
    #
  end.save_data File.join(dirname, "Troops.rvdata2")

  d.create_states do |b|
    #
  end.save_data File.join(dirname, "States.rvdata2")

  d.create_animations do |b|
    #
  end.save_data File.join(dirname, "Animations.rvdata2")

  d.create_tilesets do |b|
    #
  end.save_data File.join(dirname, "Tilesets.rvdata2")

  d.create_common_events do |b|
    #
  end.save_data File.join(dirname, "CommonEvents.rvdata2")

  save_data(d.create_system do |s|
    #
  end, File.join(dirname, "System.rvdata2"))

end

__END__

rv 1.1.0 Added States
