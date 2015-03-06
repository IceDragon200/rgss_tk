require "rgss_tk/core_ext/kernel"

module RgssTk
  def self.dump_move_route(move_route, filename)
    save_data(move_route, filename)
  end

  def self.dump_event_list(event_list, filename)
    save_data(event_list, filename)
  end
end
