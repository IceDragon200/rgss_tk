require 'rgss_tk/builder_base'

module RgssTk
  class MoveRouteBuilder < BuilderBase
    def render
      mvroute = RPG::MoveRoute.new
      mvroute.list = @list.dup
      mvroute
    end

    def _mvcmd(code, *parameters)
      push RPG::MoveCommand.new(code, parameters)
    end

    def nocmd
      _mvcmd 0
    end

    def mend
      _mvcmd 0
    end

    def move_down
      _mvcmd 1
    end

    def move_left
      _mvcmd 2
    end

    def move_right
      _mvcmd 3
    end

    def move_up
      _mvcmd 4
    end

    def move_lower_left
      _mvcmd 5
    end

    def move_lower_right
      _mvcmd 6
    end

    def move_upper_left
      _mvcmd 7
    end

    def move_upper_right
      _mvcmd 8
    end

    def move_random
      _mvcmd 9
    end

    def move_toward
      _mvcmd 10
    end

    def move_away
      _mvcmd 11
    end

    def move_forward
      _mvcmd 12
    end

    def move_backward
      _mvcmd 13
    end

    def jump(x, y)
      _mvcmd 14, x, y
    end

    def wait(n)
      _mvcmd 15, n
    end

    def turn_down
      _mvcmd 16
    end

    def turn_left
      _mvcmd 17
    end

    def turn_right
      _mvcmd 18
    end

    def turn_up
      _mvcmd 19
    end

    def turn_90d_right
      _mvcmd 20
    end

    def turn_90d_left
      _mvcmd 21
    end

    def turn_180d
      _mvcmd 22
    end

    def turn_90d_right_or_left
      _mvcmd 23
    end

    def turn_90d_random
      _mvcmd 24
    end

    def turn_toward
      _mvcmd 25
    end

    def turn_away
      _mvcmd 26
    end

    def switch_on(switch_id)
      _mvcmd 27, switch_id
    end

    def switch_off(switch_id)
      _mvcmd 28, switch_id
    end

    def change_speed(new_speed)
      _mvcmd 29, new_speed
    end

    def change_freq(new_freq)
      _mvcmd 30, new_freq
    end

    def walk_anim_on
      _mvcmd 31
    end

    def walk_anim_off
      _mvcmd 32
    end

    def walk_anim(bool)
      bool ? walk_anim_on : walk_anim_off
    end

    def step_anim_on
      _mvcmd 33
    end

    def step_anim_off
      _mvcmd 34
    end

    def step_anim(bool)
      bool ? step_anim_on : step_anim_off
    end

    def dir_fix_on
      _mvcmd 35
    end

    def dir_fix_off
      _mvcmd 36
    end

    def dir_fix(bool)
      bool ? dir_fix_on : dir_fix_off
    end

    def through_on
      _mvcmd 37
    end

    def through_off
      _mvcmd 38
    end

    def through(bool)
      bool ? through_on : through_off
    end

    def transparent_on
      _mvcmd 39
    end

    def transparent_off
      _mvcmd 40
    end

    def transparent(bool)
      bool ? transparent_on : transparent_off
    end

    def change_graphic(character_name, character_index)
      _mvcmd 41, character_name, character_index
    end

    def change_opacity(new_opacity)
      _mvcmd 42, new_opacity
    end

    def change_blending(new_blending)
      _mvcmd 43, new_blending
    end

    def play_se(se)
      _mvcmd 44, se
    end
    alias :se_play :play_se

    def script(str)
      _mvcmd 45, str
    end
    alias :eeval :script
  end
end
