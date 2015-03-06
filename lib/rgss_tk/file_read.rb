require "rgss_tk/move_route_builder"
require "rgss_tk/event_list_builder"

module RgssTk
  def self.load_move_route_file(filename)
    MoveRouteBuilder.render_file(filename)
  end

  def self.load_event_list_file(filename)
    EventListBuilder.render_file(filename)
  end
end
