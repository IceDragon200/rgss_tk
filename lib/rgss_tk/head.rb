module RgssTk
  module_function

  def tokenize(ary)
    result = []
    ary.each_with_index do |line, i|
      (warn "nulls found in ary" && next) unless line
      str = line.delete("\n")
      # is a label line
      tokendata = if data = str.match(/\A\s*(?<name>\S+):/)
        [:label, data[:name]]
      # is a instruction line
      elsif data = str.match(/\A\s*(?<name>\S+)(?:\s+(?<params>.+))?/)
        [:inst, data[:name], data[:params]]
      else
        [:null]
      end
      result.push({ line: i, raw: line, token: tokendata})
    end
    result
  end

  def read_easm_stream(stream)
    @variable_table = {}
    stream_nc_ary = stream.each_line.map do |l|
      l.gsub!(/;(.*)/, '');
      l.delete!("\n")
      l.delete!("\r")
      l
    end
    # preprocess
    stream_pp_ary = stream_nc_ary.map do |line|
      if data = line.match(/\#undef\s+(?<name>\S+)/)
        @variable_table.delete(data[:name])
        nil
      elsif data = line.match(/\#define\s+(?<name>\S+)(?:\s+(?<value>.+))?/)
        v = data[:value].to_s
        v.gsub!(@variable_table)
        @variable_table[data[:name]] = v
        nil
      else
        v = line.to_s
        v.gsub!(@variable_table)
        v.gsub!(/\A\s+/, '') # remove preceding whitespace
        v.gsub!(/\s+\z/, '') # remove trailing whitespace
        v
      end
    end
    # convert to Token hashes
    return tokenize(stream_pp_ary)
  end

  def load_easm_file(filename)
    tokenlist = read_easm_stream(File.open(filename, "r"))
    tokenlist
  end

  module TokenToEventCommands

    EventCommmand = Struct.new(:name, :code, :param_types, :cb)

    extend self

    @evcmds = {}

    class << self
      attr_reader :evcmds
    end

    ## TODO
    #
    def tokenlist_to_eventcommands!(tokenlist)

    end

    def evcmd(token_name, evcmd_id, *param_types, &block)
      @evcmds[token_name] = EventCommmand.new(token_name, evcmd_id, param_types, block)
    end

    def evcmd_alias(newname, oldname)
      @evcmds[newname] = oldname
    end

    ### RMVXA Event Commands
    ##    name                     code  Types
    #
    evcmd :null,                      0
    # show_text face_name, face_index, background, position
    evcmd :show_text,               101, :String, :Integer, :String, :Integer
    evcmd :text,                    401, :String
    ##
    # show_choice ["String", "String", ...], cancel_choice_type
    evcmd :show_choice,             102, [:String], :Integer
    evcmd :choice_branch,           402, :Integer, :String   # When [**]
    evcmd :choice_cancel,           403                      # When Cancel
    evcmd :branch_end,              404                      # Choice End
    ##
    # show_num_input var_id, digits_max
    evcmd :show_num_input,          103, :Integer, :Integer
    ##
    # show_item_choice trg_var_id
    evcmd :show_item_choice,        104, :Integer
    ##
    # show_text_scrolling scroll_speed, scroll_no_fast
    evcmd :show_text_scrolling,     105, :Integer, :Boolean
    evcmd :text_scrolling,          405, :String
    ##
    # comment Comment String
    evcmd :comment,                 108, :String
    evcmd :comment_text,            408, :String
    ##
    # conditional_branch operand_type, *
    # ^^ 0, switch_id, expected_value                  # Fixed
    # ^^ 1, variable_id, is_value, p1, operator        # Variable
    # ^^ 1, variable_id, 0, expected_value, operator   #
    # ^^ 1, variable_id, 1, variable_id2, operator     #
    #   @operator
    #     0: equal
    #     1: greater than or equal to
    #     2: less than or equal to
    #     3: greater than
    #     4: less than
    #     5: not equal
    # ^^ 2, self_switch_id, expected_value             # Self Switch
    # ^^ 3, is_less_than_or_equal_to, expected_value   # Timer
    # ^^ 3, 0, expected_value                          #   expected_value less than or equal to timer
    # ^^ 3, 1, expected_value                          #   expected_value greater than or equal to timer
    # ^^ 4, actor_id, operand_type2, *                 # Actor
    # ^^ 4, actor_id, 0                                #   actor in party?
    # ^^ 4, actor_id, 1, name                          #   actor name ==
    # ^^ 4, actor_id, 2, class_id                      #   actor class_id ==
    # ^^ 4, actor_id, 3, skill_id                      #   actor has skill?
    # ^^ 4, actor_id, 4, weapon_id                     #   actor has weapon?
    # ^^ 4, actor_id, 5, armor_id                      #   actor has armor?
    # ^^ 4, actor_id, 6, state_id                      #   actor has state?
    # ^^ 5, enemy_index, operand_type2, *              # Enemy
    # ^^ 5, enemy_index, 0                             #   enemy is alive?
    # ^^ 5, enemy_index, 1, state_id                   #   enemy has state?
    # ^^ 6, character_id, direction                    # Character direction
    # ^^ 7, expected_value, operator                   # Gold
    evcmd :conditional_branch,      111, :Integer, :*
    evcmd :conditional_branch_else, 411
    evcmd :conditional_branch_end,  412

    # loop
    evcmd :loop,                    112
    evcmd :repeat,                  413
    evcmd :break,                   113
    evcmd :terminate,               115
    ##
    # call_common_event common_event_id
    evcmd :call_common_event,       117, :Integer
    ##
    # label_name:
    # label label_name
    evcmd :label,                   118, :String
    ##
    # jump_to_label label_name
    evcmd :jump_to_label,           119, :String
    ##
    # control_switch range_start, range_end, state
    evcmd :control_switch,          121, :Integer, :Integer, :Integer
    ###
    # control_variable range_start, range_end, operation, operand_type, *
    # @operation
    #   0: set
    #   1: add
    #   2: sub
    #   3: mul
    #   4: div
    #   5: mod
    # @operand_type
    #   0: value
    #   1: variable
    #   2: random
    #   3: game_data
    #   4: script
    # ^^ ^, ^, ^, 0, value                     # set
    # ^^ ^, ^, ^, 1, variable_id               # set from variable
    # ^^ ^, ^, ^, 2, floor/base, ceil/cap      # random range
    # ^^ ^, ^, ^, 3, type, param1, param2      # Game Data
    # ^^ ^, ^, ^, 3, 0, item_id                #   item count
    # ^^ ^, ^, ^, 3, 1, weapon_id              #   weapon count
    # ^^ ^, ^, ^, 3, 2, armor_id               #   armor count
    # ^^ ^, ^, ^, 3, 3, actor_id, param_id     #   actor attribute
    # ^^ ^, ^, ^, 3, 3, actor_id, 0            #     level
    # ^^ ^, ^, ^, 3, 3, actor_id, 1            #     exp
    # ^^ ^, ^, ^, 3, 3, actor_id, 2            #     hp
    # ^^ ^, ^, ^, 3, 3, actor_id, 3            #     mp
    # ^^ ^, ^, ^, 3, 3, actor_id, 4            #     mhp
    # ^^ ^, ^, ^, 3, 3, actor_id, 5            #     mmp
    # ^^ ^, ^, ^, 3, 3, actor_id, 6            #     atk
    # ^^ ^, ^, ^, 3, 3, actor_id, 7            #     def
    # ^^ ^, ^, ^, 3, 3, actor_id, 8            #     mat
    # ^^ ^, ^, ^, 3, 3, actor_id, 9            #     mdf
    # ^^ ^, ^, ^, 3, 3, actor_id, 10           #     agi
    # ^^ ^, ^, ^, 3, 3, actor_id, 11           #     luk
    # ^^ ^, ^, ^, 3, 4, param1, param2         #   enemy attribute
    # ^^ ^, ^, ^, 3, 4, enemy_id, 0            #     hp
    # ^^ ^, ^, ^, 3, 4, enemy_id, 1            #     mp
    # ^^ ^, ^, ^, 3, 4, enemy_id, 2            #     mhp
    # ^^ ^, ^, ^, 3, 4, enemy_id, 3            #     mmp
    # ^^ ^, ^, ^, 3, 4, enemy_id, 4            #     atk
    # ^^ ^, ^, ^, 3, 4, enemy_id, 5            #     def
    # ^^ ^, ^, ^, 3, 4, enemy_id, 6            #     mat
    # ^^ ^, ^, ^, 3, 4, enemy_id, 7            #     mdf
    # ^^ ^, ^, ^, 3, 4, enemy_id, 8            #     agi
    # ^^ ^, ^, ^, 3, 4, enemy_id, 9            #     luk
    # ^^ ^, ^, ^, 3, 5, character_id, param_id #   character attribute
    # ^^ ^, ^, ^, 3, 5, character_id, 0        #     x
    # ^^ ^, ^, ^, 3, 5, character_id, 1        #     y
    # ^^ ^, ^, ^, 3, 5, character_id, 2        #     direction
    # ^^ ^, ^, ^, 3, 5, character_id, 3        #     screen_x
    # ^^ ^, ^, ^, 3, 5, character_id, 4        #     screen_y
    # ^^ ^, ^, ^, 3, 6, party_member_index     #   party_member_id
    # ^^ ^, ^, ^, 3, 7, param1                 #   Other Data
    # ^^ ^, ^, ^, 3, 7, 0                      #     map_id
    # ^^ ^, ^, ^, 3, 7, 1                      #     party members count
    # ^^ ^, ^, ^, 3, 7, 2                      #     gold
    # ^^ ^, ^, ^, 3, 7, 3                      #     steps
    # ^^ ^, ^, ^, 3, 7, 4                      #     playtime
    # ^^ ^, ^, ^, 3, 7, 5                      #     timer
    # ^^ ^, ^, ^, 3, 7, 6                      #     save count
    # ^^ ^, ^, ^, 3, 7, 7                      #     battle count
    # ^^ ^, ^, ^, 4, script                    # eval
    ###
    evcmd :control_variable,        122, :Integer, :Integer, :Integer, :Integer, :*
    ##
    # control_self_switch self_switch_id, state
    evcmd :control_self_switch,     123, :String, :Integer
    ##
    # control_timer 0, time_in_secs
    # control_timer 1 # turn off
    evcmd :control_timer,           124, :Integer, :Integer
    ##
    # change_gold operation, operand_type, operand
    # change_gold 0, operand_type, operand # increase
    # change_gold 0, 0, integer            #   constant
    # change_gold 0, 1, var_id             #   variable
    # change_gold 1, operand_type, operand # decrease
    # change_gold 1, 0, integer            #   constant
    # change_gold 1, 1, var_id             #   variable
    evcmd :change_gold,             125, :Integer, :Integer, :Integer
    ##
    # change_item item_id, operation, operand_type, operand
    # change_item item_id, 0, operand_type, operand # increase
    # change_item item_id, 0, 0, integer            #   constant
    # change_item item_id, 0, 1, var_id             #   variable
    # change_item item_id, 1, operand_type, operand # descrease
    # change_item item_id, 1, 0, integer            #   constant
    # change_item item_id, 1, 1, var_id             #   variable
    evcmd :change_item,             126, :Integer, :Integer, :Integer, :Integer
    ##
    # change_weapon weapon_id, operation, operand_type, operand, check_equipped
    # change_weapon weapon_id, 0, operand_type, operand, check_equipped # increase
    # change_weapon weapon_id, 0, 0, integer, check_equipped            #   constant
    # change_weapon weapon_id, 0, 1, var_id, check_equipped             #   variable
    # change_weapon weapon_id, 1, operand_type, operand, check_equipped # decrease
    # change_weapon weapon_id, 1, 0, integer, check_equipped            #   constant
    # change_weapon weapon_id, 1, 1, var_id, check_equipped             #   variable
    evcmd :change_weapon,           127, :Integer, :Integer, :Integer, :Integer, :Integer
    ##
    # change_armor armor_id, operation, operand_type, operand, check_equipped
    # change_armor armor_id, 0, operand_type, operand, check_equipped # increase
    # change_armor armor_id, 0, 0, integer, check_equipped            #   constant
    # change_armor armor_id, 0, 1, var_id, check_equipped             #   variable
    # change_armor armor_id, 1, operand_type, operand, check_equipped # decrease
    # change_armor armor_id, 1, 0, integer, check_equipped            #   constant
    # change_armor armor_id, 1, 1, var_id, check_equipped             #   variable
    evcmd :change_armor,            128, :Integer, :Integer, :Integer, :Integer, :Integer
    ##
    # change_party_member 0, actor_id # add actor
    # change_party_member 1, actor_id # remove actor
    evcmd :change_party_member,     129, :Integer, :Integer
    ## TODO
    # change_battle_bgm bgm
    evcmd :change_battle_bgm,       132, "RPG::BGM"
    ## TODO
    # change_battle_end_me me
    evcmd :change_battle_end_me,    133, "RPG::ME"
    ##
    # change_save_access state
    evcmd :change_save_access,      134, :Integer
    ##
    # change_menu_access state
    evcmd :change_menu_access,      135, :Integer
    ##
    # change_encounter state
    evcmd :change_encounter,        136, :Integer
    ##
    # change_formation_access state
    evcmd :change_formation_access, 137, :Integer
    ##
    # change_window_tone state
    evcmd :change_window_tone,      138, :Tone
    ##
    # transfer_player opcode, map_id, p1, p2, keep_dir, fade_type # player moveto(p1, p2)
    # transfer_player 0, map_id, x, y, keep_dir, fade_type        # player moveto(x, y)
    # transfer_player 1, map_id, var1, var2, keep_dir, fade_type  # player moveto(variable(var1), variable(var2))
    evcmd :set_player_position,     201, :Integer, :Integer, :Integer, :Integer, :Integer
    ##
    # set_vehicle_position vehicle_id, opcode, map_id, p1, p2, keep_dir, fade_type
    # set_vehicle_position vehicle_id, 0, map_id, x, y, keep_dir, fade_type
    # set_vehicle_position vehicle_id, 1, map_id, var1, var2, keep_dir, fade_type
    evcmd :set_vehicle_position,    202, :Integer, :Integer, :Integer, :Integer, :Integer
    ##
    # set_event_position event_id, opcode, map_id, p1, p2, keep_dir, fade_type
    # set_event_position event_id, 0, map_id, x, y, keep_dir, fade_type
    # set_event_position event_id, 1, map_id, var1, var2, keep_dir, fade_type
    # set_event_position event_id, 2, map_id, char_id, _, keep_dir, fade_type
    evcmd :set_event_position,      203, :Integer, :Integer, :Integer, :Integer, :Integer
    ## TODO
    # scroll_map ***
    evcmd :scroll_map,              204, :Integer, :Integer, :Integer
    ## TODO
    # set_move_route char_id, move_route
    evcmd :set_move_route,          205, :Integer, "RPG::Event::MoveRoute"
    ##
    # get_on_off_vehicle
    evcmd :get_on_off_vehicle,      206
    ##
    # change_transperency state
    evcmd :change_transperency,     211, :Integer
    ##
    # show_animation char_id, animation_id, wait_for_animation
    evcmd :show_animation,          212, :Integer, :Integer, :Integer
    ##
    # show_balloon char_id, balloon_id, wait_for_balloon
    evcmd :show_balloon,            213, :Integer, :Integer, :Integer
    ##
    # erase_event
    evcmd :erase_event,             214
    ##
    # set_followers_visiblity state
    evcmd :set_followers_visiblity, 216, :Integer
    ##
    # gather_followers
    evcmd :gather_followers,        217
    ##
    # screen_fadeout
    evcmd :screen_fadeout,          221
    ##
    # screen_fadein
    evcmd :screen_fadein,           222
    ##
    # screen_tint tone, time, wait
    evcmd :screen_tint,             223, :Tone, :Integer, :Boolean
    ##
    # screen_flash color, time, wait
    evcmd :screen_flash,            224, :Color, :Integer, :Boolean
    ##
    # screen_shake power, speed, time, wait
    evcmd :screen_shake,            225, :Integer, :Integer, :Integer, :Boolean
    ##
    # wait time
    evcmd :wait,                    230, :Integer
    ##
    # show_picture picture_id, name, origin, pos_code, p1, p2, zoom_x, zoom_y, opacity, blend_type
    # show_picture picture_id, name, origin, 0, x, y, zoom_x, zoom_y, opacity, blend_type
    # show_picture picture_id, name, origin, 1, var_id1, var_id2, zoom_x, zoom_y, opacity, blend_type
    evcmd :show_picture,            231, :Integer, :String, :Integer, :Integer, :Integer, :Integer, :Integer, :Integer, :Integer, :Integer
    ## TODO
    # move_picture
    evcmd :move_picture,            232, :Integer, :Integer, :Integer, :Integer, :Integer, :Integer, :Integer, :Integer, :Integer, :Integer, :Integer, :Integer
    ##
    # rotate_picture picture_id, angle
    evcmd :rotate_picture,          233, :Integer, :Integer
    ##
    # tint_picture picture_id, tone, time, wait
    evcmd :tint_picture,            234, :Integer, :Integer, :Integer, :Integer
    ##
    # erase_picture picture_id
    evcmd :erase_picture,           235, :Integer
    ## TODO
    # set_weather **
    evcmd :set_weather,             236, :Integer, :Integer, :Integer, :Integer, :Integer
    ## TODO
    # set_weather **
    evcmd :set_weather,             236, :Integer, :Integer, :Integer, :Integer, :Integer

    ## TODO
    # bgm_play bgm
    evcmd :bgm_play,                241, "RPG::BGM"
    ##
    # bgm_fadeout time_in_seconds
    evcmd :bgm_fadeout,             242, :Integer
    ##
    # bgm_save
    evcmd :bgm_save,                243
    ##
    # bgm_resume
    evcmd :bgm_resume,              244
    ## TODO
    # bgs_play bgs
    evcmd :bgs_play,                245, "RPG::BGS"
    ##
    # bgs_fadeout time_in_seconds
    evcmd :bgs_fadeout,             246, :Integer
    ## TODO
    # me_play me
    evcmd :me_play,                 249, "RPG::ME"
    ## TODO
    # se_play se
    evcmd :se_play,                 250, "RPG::SE"
    ##
    # se_stop
    evcmd :se_stop,                 251

    ##
    # movie_play filename
    evcmd :movie_play,              261, :String

    ##
    # set_map_name_display state
    evcmd :set_map_name_display,    281, :Integer

    ##
    # change_tileset tileset
    evcmd :change_tileset,          282, "RPG::Tileset"

    ## TODO
    # change_battle_background
    evcmd :change_battle_background,283, :String, :String

    ## TODO
    # change_parallax_background
    evcmd :change_parallax_background,284, :String, :Boolean, :Boolean, :Integer, :Integer

    ##
    # get_location_info variable_id, info_id, is_direct, x, y
    evcmd :get_location_info,       285, :Integer, :Integer, :Integer, :Integer, :Integer

    ##
    # process_battle opcode, p1, can_escape, can_lose
    # process_battle 0, troop_id, can_escape, can_lose
    # process_battle 1, var_id, can_escape, can_lose
    # process_battle 2, nil, can_escape, can_lose
    evcmd :process_battle,          301, :Integer, :Integer, :Boolean, :Boolean
    evcmd :battle_branch_win,       601
    evcmd :battle_branch_escape,    602
    evcmd :battle_branch_lose,      603
    ##
    # process_shop shop_item, purchase_only
    evcmd :process_shop,            302, [], :Boolean
    # shop_item item_type, item_id, overload_price, new_price
    evcmd :shop_item,               605, :Integer, :Integer, :Boolean, :Integer
    ##
    # process_name_input actor_id, max_char
    evcmd :process_name_input,      303, :Integer, :Integer
    ##
    # process_menu
    evcmd :process_menu,            351
    ##
    # process_save
    evcmd :process_save,            352
    ##
    # process_gameover
    evcmd :process_gameover,        353
    ##
    # process_title
    evcmd :process_title,           354

    ## TODO
    # change_actor_hp
    evcmd :change_actor_hp,         311, :Unknown, :Unknown, :Unknown, :Unknown, :Unknown, :Unknown
    ## TODO
    # change_actor_mp
    evcmd :change_actor_mp,         312, :Unknown, :Unknown, :Unknown, :Unknown, :Unknown
    ## TODO
    # change_actor_state
    evcmd :change_actor_state,      313, :Unknown, :Unknown, :Unknown, :Unknown
    ## TODO
    # actor_recover_all
    evcmd :actor_recover_all,       314, :Unknown, :Unknown
    ## TODO
    # change_actor_exp
    evcmd :change_actor_exp,        315, :Unknown, :Unknown, :Unknown, :Unknown, :Unknown, :Unknown
    ## TODO
    # change_actor_level
    evcmd :change_actor_level,      316, :Unknown, :Unknown, :Unknown, :Unknown, :Unknown, :Unknown
    ## TODO
    # change_actor_parameters
    evcmd :change_actor_parameters, 317, :Unknown, :Unknown, :Unknown, :Unknown, :Unknown, :Unknown
    ## TODO
    # change_actor_skill
    evcmd :change_actor_skill,      318, :Unknown, :Unknown, :Unknown, :Unknown
    ## TODO
    # change_actor_equip
    evcmd :change_actor_equip,      319, :Unknown, :Unknown, :Unknown
    ##
    # change_actor_name actor_id, new_name
    evcmd :change_actor_name,       320, :Integer, :String
    ##
    # change_actor_class actor_id, class_id
    evcmd :change_actor_class,      321, :Integer, :Integer
    ##
    # change_actor_graphic actor_id, character_name, character_index, face_name, face_index
    evcmd :change_actor_graphic,    322, :Integer, :String, :Integer, :String, :Integer
    ##
    # change_graphic actor_id, character_name, character_index, face_name, face_index
    evcmd :change_vehicle_graphic,  323, :Integer, :String, :Integer
    ##
    # change_actor_nickname actor_id, new_name
    evcmd :change_actor_nickname,   324, :Integer, :String

    ## TODO
    # change_enemy_hp
    evcmd :change_enemy_hp,         331
    ## TODO
    # change_enemy_mp
    evcmd :change_enemy_mp,         332
    ## TODO
    # change_enemy_state
    evcmd :change_enemy_state,      333
    ##
    # enemy_recover_all
    evcmd :enemy_recover_all,       334
    ##
    # enemy_appear enemy_index
    evcmd :enemy_appear,            335, :Integer
    ##
    # enemy_transform enemy_index, new_enemy_id
    evcmd :enemy_transform,         336, :Integer, :Integer
    ##
    # show_battle_animation enemy_index, animation_id
    evcmd :show_battle_animation,   337, :Integer, :Integer
    ## TODO
    # battle_force_action
    evcmd :battle_force_action,     339, :Unknown, :Unknown, :Unknown, :Unknown
    ##
    # battle_abort
    evcmd :battle_abort,            340

    ##
    # script ruby_string
    evcmd :script,                  355, :String
    evcmd :script_text,             655, :String

    ### aliases
    evcmd_alias :if, :conditional_branch
    evcmd_alias :transfer_player, :set_player_position
    evcmd_alias :eval, :script

    #evcmds.each_value do |ec|
    #  puts "#{ec.code} => \"#{ec.name}\"" if ec.is_a?(EventCommmand)
    #end
  end
  class EventCommandBuilder < BuilderBase
    File.open("evcmd_export", "w") do |file|
        append = "_evcmd_"
        TokenToEventCommands.evcmds.each do |key, command|
          case command
          ##
          when String, Symbol
            file.puts "def #{append+key.to_s}(*a, &b); #{append+command.to_s}(*a, &b); end"
            define_method(append+key.to_s) { |*args, &block| send(append+command.to_s, *args, &block) }
          ## EventCommmand<:name, :id, :param_types, :cb>
          when TokenToEventCommands::EventCommmand
            file.puts "def #{append+key.to_s}(*a, &b); _evcmd(#{command.code}, indent, a); end"
            define_method(append+key.to_s) do |*args, &block|
              result = args
              result = command.cb.call(*args, &block) if command.cb
              push(RPG::EventCommand.new(command.code, indent, result))
            end
          else
            warn "Unknown command type #{command.class}"
          end
        end
    end
    # puts instance_methods.select { |str| str.to_s.start_with?(append) }
  end
end

__END__
# ####### MESSAGE #######
# Show Text, displays text (speech)
show_text                                101 ["", 0, 0, 2]
text                                     401 ["text goes here"]
# Show choices, displays choices (yes, no)
show_choice                              102 [["Yes", "No"], 2]
branch_choice                            402 [0, "Yes"]
  null                                     000 []
branch_choice                            402 [1, "No"]
  null                                     000 []
branch_end                               404 []
# Input a number (ties into variables)
show_num_input                           103 [1, 1]
# Select a key item
show_item_choice                         104 [1]
# scrolling text, easy enough
show_text_scrolling                      105 [2, false]
text_scrolling                           405 ["yoloswag"]
text_scrolling                           405 ["420mlg"]
# ####### GAME PROGRESSION ######
# control switches through this event by turning them on/off
control_switch                           121 [1, 1, 0]
# same as above but with variables
control_variable                         122 [1, 1, 0, 0, 0]
# self switches!
control_self_switch                      123 ["A", 0]
# this is the timer
control_timer                            124 [0, 60]
# ####### FLOW CONTROL #######
# Conditional Brances, basically if "x" or "y" (any variable you want)
# is fulilled (or not) it would branch off
conditional_branch                       111 [0, 1, 0]
  null                                     000 []
branch_else                              411 []
  null                                     000 []
                                         412 []
# loop (start)
loop                                     112 []
  null                                     000 []
repeat                                   413 []
# break loop
break                                    113 []
# exit event processing
terminate                                115 []
# Call common event
call_common_event                        117 [1]
# Label
label                                    118 ["hjg"]
# jump to the specific label
jump_to_label                            119 ["hjg"]
# ####### CHANGE PARTY (ITEMS) #######
# change gold in inventory
change_gold                              125 [0, 0, 1]
# change items
change_item                              126 [2, 0, 0, 1]
# change weapons
change_weapon                            127 [1, 0, 0, 1, false]
# change armor
change_armor                             128 [1, 0, 0, 1, false]
# change party member
change_party_member                      129 [1, 0, 0]
# ####### CHANGE ACTOR STATS #######
# change actor HP
change_actor_hp                          311 [0, 0, 0, 0, 1, false]
# change MP
change_actor_mp                          312 [0, 0, 0, 0, 1]
# change state
change_actor_state                       313 [0, 0, 0, 8]
# recover all; heals your health
actor_recover_all                        314 [0, 0]
# change EXP
change_actor_exp                         315 [0, 0, 0, 0, 1, false]
# change level
change_actor_level                       316 [0, 0, 0, 0, 1, false]
# change parameters (edit stats)
change_actor_parameters                  317 [0, 1, 0, 0, 0, 1]
# add/remove skills
change_actor_skill                       318 [0, 1, 0, 23]
# change equipment for a party member
change_actor_equip                       319 [1, 0, 0]
# change a characters name
change_actor_name                        320 [1, "Poopman"]
# change a characters class
change_actor_class                       321 [1, 1]
# change nickname
change_actor_nickname                    324 [1, "EROCK"]
null                                     000 []
# ###### MOVEMENT COMMANDS ######
# Transfer player to map id/coordinates
set_player_position                      201 [0, 1, 6, 10, 0, 0]
# set vehicle location
set_vehicle_position                     202 [0, 0, 1, 5, 6]
# set event location
set_event_position                       203 [0, 0, 5, 6, 0]
# scroll/move around your map
scroll_map                               204 [2, 1, 4]
# set move route for an event
set_move_route                           205 [-1, {"repeat"=>false, "skippable"=>false, "wait"=>true, "list"=>[{"code"=>4, "parameters"=>[]}, {"code"=>0, "parameters"=>[]}]}]
                                         505 [{"code"=>4, "parameters"=>[]}]
# get on/off vehicle
get_on_off_vehicle                       206 []
# ####### CHARACTER #######
# change character transparency on/off
change_transperency                      211 [0]
# disable/enable player followers
set_followers_visiblity                  216 [0]
# gather followers
gather_followers                         217 []
# show animation (by id)
show_animation                           212 [-1, 1, false]
# show balloon icon
show_balloon                             213 [-1, 1, false]
# erase event
erase_event                              214 []
# ####### SCREEN EFFECTS #######
# fadeout screen
screen_fadeout                           221 []
# fade in screen
screen_fadein                            222 []
# tint screen
screen_tint                              223 [{}, 60, true]
# flash screen
screen_flash                             224 [{}, 60, true]
# shake screen
screen_shake                             225 [5, 5, 60, true]
# ####### WAIT #######
# wait for a set amount of frames
wait                                     230 [60]
# ####### PICTURE AND WEATHER #######
# show picture
show_picture                             231 [1, "", 0, 0, 0, 0, 100, 100, 255, 0]
# move picture
move_picture                             232 [1, nil, 0, 0, 0, 0, 100, 100, 255, 0, 60, true]
# rotate picture
rotate_picture                           233 [1, 5]
# tint picture
tint_picture                             234 [1, {}, 60, true]
# erase picture
erase_picture                            235 [1]
# set weather effects
set_weather                              236 [":none", 9, 0, true]
# ####### MUSIC AND SOUNDS #######
# PLAY BGM
bgm_play                                 241 [{"name"=>"Airship", "volume"=>100, "pitch"=>100}]
# fadeout bgm
bgm_fadeout                              242 [10]
# save bgm location
bgm_save                                 243 []
# replay bgm
bgm_resume                               244 []
# play background sound
bgs_play                                 245 [{"name"=>"Drips", "volume"=>80, "pitch"=>100}]
# fadeout bgs
bgs_fadeout                              246 [10]
# play ME
me_play                                  249 [{"name"=>"Gameover1", "pitch"=>100, "volume"=>100}]
# play sound effect
se_play                                  250 [{"name"=>"Bite", "pitch"=>100, "volume"=>80}]
# stop sound effect
se_stop                                  251 []
null                                     000 []
# ####### SCENE CONTROL #######
# battle processing
process_battle                           301 [0, 1, false, false]
# Shop processing
process_shop                             302 [0, 1, 0, 0, false]
# name input processing, allows the player to choose a name
process_name_input                       303 [1, 6]
# force open menu screen
process_menu                             351 []
# force open save screen
process_save                             352 []
# game over
process_gameover                         353 []
# return to title screen
process_title                            354 []
# ####### SYSTEM SETTINGS #######
# change battle music
change_battle_bgm                        132 [{"name"=>"Dungeon2", "volume"=>100, "pitch"=>100}]
# change battle end jingle
change_battle_end_me                     133 [{"name"=>"Victory1", "pitch"=>100, "volume"=>100}]
# enable/disable save ability
change_save_access                       134 [0]
# enable/disable menu access
change_menu_access                       135 [0]
# enable/disable random encounters
change_encounter                         136 [0]
# change access to formation
change_formation_access                  137 [0]
# change window color
change_window_tone                       138 [{}]
# change actor graphic (sprite and face)
change_actor_graphic                     322 [1, "Actor4", 0, "Actor4", 0]
# change vehicle graphic
change_vehicle_graphic                   323 [1, "Vehicle", 1]
# play movie
movie_play                               261 [""]
# ####### MAP ######
# toggle map name display
set_map_name_display                     281 [0]
# change tileset
change_tileset                           282 [1]
# change battleback
change_battle_background                 283 ["DecorativeTile", "DemonCastle2"]
# change parallax background
change_parallax_background               284 ["SeaofClouds", false, false, 0, 0]
# get location info (id tags, coordinates) from a specific coordinate
get_location_info                        285 [1, 0, 0, 5, 8]
# ####### BATTLE STUFF ######
# increase/decrease enemy HP
change_enemy_hp                          331 [-1, 0, 0, 1, false]
# increase/decrease enemy MP
change_enemy_mp                          332 [-1, 0, 0, 1]
# change enemy state
change_enemy_state                       333 [-1, 0, 7]
# recover all enemies HP
enemy_recover_all                        334 [-1]
# enemy appears
enemy_appear                             335 [0]
# enemy transforms
enemy_transform                          336 [0, 1]
# show battle animation
show_battle_animation                    337 [-1, 1]
# force an action
battle_force_action                      339 [0, 0, 1, -1]
# abort battle
battle_abort                             340 []
# ############## SCRIPT cALL
script                                   355 [""]
null                                     000 []

__END__

test_easm = <<-__EOF__
#define CONSTANT "delta"
#define XINST inst2

main:
  inst1
  XINST CONSTANT ; something
  if (x == y)
    inst3
  endif
  ; comment
__EOF__

puts RgssTk.read_easm_stream(test_easm).map(&:inspect).join("\n")
