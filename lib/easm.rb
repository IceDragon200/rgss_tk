#
# easm.rb
# by IceDragon
# dm 31/05/2014
#   EASM is a module for writing events using a ruby DSL.
#   EASM is converted to the proper RMVXA event commands as needed.
#   EASM seeks to ease the creation of event lists through its functions.
module EASM
  module Version
    MAJOR, MINOR, PATCH, BUILD = 1, 0, 0, nil
    STRING = [MAJOR, MINOR, PATCH, BUILD].compact.join('.')
  end
  VERSION = Version::STRING
end

require 'rgss_tk/version'
require 'rgss_tk/file_read'
require 'rgss_tk/event_list_builder'
require 'rgss_tk/move_route_builder'
