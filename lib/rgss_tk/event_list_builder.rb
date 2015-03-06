require 'rgss_tk/event_command_codes'
require 'rgss_tk/event_command_parameter_codes'
require 'rgss_tk/builder_base'
require 'rgss_tk/move_route_builder'

module RgssTk
  class EventListBuilder < BuilderBase
    include EventCommandCodes
    include EventCommandParameterCodes

    attr_accessor :indent

    def initialize
      super
      @indent = 0
    end

    def _inc_indent
      @indent += 1
      if block_given?
        yield
        _dec_indent
      end
    end

    def _dec_indent
      @indent -= 1
    end

    def _evcmd(code, indent, params)
      event_command = RPG::EventCommand.new(code, indent, params)
      @debug.puts "pushing #{event_command.inspect}"
      push event_command
    end

    def _evcmd_null(*a, &b);                       _evcmd(CODE_NULL, indent, a); end
    def _evcmd_show_text(*a, &b);                  _evcmd(CODE_SHOW_TEXT, indent, a); end
    def _evcmd_text(*a, &b);                       _evcmd(CODE_TEXT, indent, a); end
    def _evcmd_show_choice(*a, &b);                _evcmd(CODE_SHOW_CHOICE, indent, a); end
    def _evcmd_choice_branch(*a, &b);              _evcmd(CODE_CHOICE_BRANCH, indent, a); end
    def _evcmd_choice_cancel(*a, &b);              _evcmd(CODE_CHOICE_CANCEL, indent, a); end
    def _evcmd_branch_end(*a, &b);                 _evcmd(CODE_BRANCH_END, indent, a); end
    alias :_evcmd_choice_end :_evcmd_branch_end
    def _evcmd_show_num_input(*a, &b);             _evcmd(CODE_SHOW_NUM_INPUT, indent, a); end
    def _evcmd_show_item_choice(*a, &b);           _evcmd(CODE_SHOW_ITEM_CHOICE, indent, a); end
    def _evcmd_show_text_scrolling(*a, &b);        _evcmd(CODE_SHOW_TEXT_SCROLLING, indent, a); end
    def _evcmd_text_scrolling(*a, &b);             _evcmd(CODE_TEXT_SCROLLING, indent, a); end
    def _evcmd_comment(*a, &b);                    _evcmd(CODE_COMMENT, indent, a); end
    def _evcmd_comment_text(*a, &b);               _evcmd(CODE_COMMENT_TEXT, indent, a); end
    def _evcmd_conditional_branch(*a, &b);         _evcmd(CODE_CONDITIONAL_BRANCH, indent, a); end
    def _evcmd_conditional_branch_else(*a, &b);    _evcmd(CODE_CONDITIONAL_BRANCH_ELSE, indent, a); end
    def _evcmd_conditional_branch_end(*a, &b);     _evcmd(CODE_CONDITIONAL_BRANCH_END, indent, a); end
    def _evcmd_loop(*a, &b);                       _evcmd(CODE_LOOP, indent, a); end
    def _evcmd_repeat(*a, &b);                     _evcmd(CODE_REPEAT, indent, a); end
    def _evcmd_break(*a, &b);                      _evcmd(CODE_BREAK, indent, a); end
    def _evcmd_terminate(*a, &b);                  _evcmd(CODE_TERMINATE, indent, a); end
    def _evcmd_call_common_event(*a, &b);          _evcmd(CODE_CALL_COMMON_EVENT, indent, a); end
    def _evcmd_label(*a, &b);                      _evcmd(CODE_LABEL, indent, a); end
    def _evcmd_jump_to_label(*a, &b);              _evcmd(CODE_JUMP_TO_LABEL, indent, a); end
    def _evcmd_control_switch(*a, &b);             _evcmd(CODE_CONTROL_SWITCH, indent, a); end
    def _evcmd_control_variable(*a, &b);           _evcmd(CODE_CONTROL_VARIABLE, indent, a); end
    def _evcmd_control_self_switch(*a, &b);        _evcmd(CODE_CONTROL_SELF_SWITCH, indent, a); end
    def _evcmd_control_timer(*a, &b);              _evcmd(CODE_CONTROL_TIMER, indent, a); end
    def _evcmd_change_gold(*a, &b);                _evcmd(CODE_CHANGE_GOLD, indent, a); end
    def _evcmd_change_item(*a, &b);                _evcmd(CODE_CHANGE_ITEM, indent, a); end
    def _evcmd_change_weapon(*a, &b);              _evcmd(CODE_CHANGE_WEAPON, indent, a); end
    def _evcmd_change_armor(*a, &b);               _evcmd(CODE_CHANGE_ARMOR, indent, a); end
    def _evcmd_change_party_member(*a, &b);        _evcmd(CODE_CHANGE_PARTY_MEMBER, indent, a); end
    def _evcmd_change_battle_bgm(*a, &b);          _evcmd(CODE_CHANGE_BATTLE_BGM, indent, a); end
    def _evcmd_change_battle_end_me(*a, &b);       _evcmd(CODE_CHANGE_BATTLE_END_ME, indent, a); end
    def _evcmd_change_save_access(*a, &b);         _evcmd(CODE_CHANGE_SAVE_ACCESS, indent, a); end
    def _evcmd_change_menu_access(*a, &b);         _evcmd(CODE_CHANGE_MENU_ACCESS, indent, a); end
    def _evcmd_change_encounter(*a, &b);           _evcmd(CODE_CHANGE_ENCOUNTER, indent, a); end
    def _evcmd_change_formation_access(*a, &b);    _evcmd(CODE_CHANGE_FORMATION_ACCESS, indent, a); end
    def _evcmd_change_window_tone(*a, &b);         _evcmd(CODE_CHANGE_WINDOW_TONE, indent, a); end
    def _evcmd_set_player_position(*a, &b);        _evcmd(CODE_SET_PLAYER_POSITION, indent, a); end
    def _evcmd_set_vehicle_position(*a, &b);       _evcmd(CODE_SET_VEHICLE_POSITION, indent, a); end
    def _evcmd_set_event_position(*a, &b);         _evcmd(CODE_SET_EVENT_POSITION, indent, a); end
    def _evcmd_scroll_map(*a, &b);                 _evcmd(CODE_SCROLL_MAP, indent, a); end
    def _evcmd_set_move_route(*a, &b);             _evcmd(CODE_SET_MOVE_ROUTE, indent, a); end
    def _evcmd_move_command(*a, &b);               _evcmd(CODE_MOVE_COMMAND, indent, a); end
    def _evcmd_get_on_off_vehicle(*a, &b);         _evcmd(CODE_GET_ON_OFF_VEHICLE, indent, a); end
    def _evcmd_change_transperency(*a, &b);        _evcmd(CODE_CHANGE_TRANSPERENCY, indent, a); end
    def _evcmd_show_animation(*a, &b);             _evcmd(CODE_SHOW_ANIMATION, indent, a); end
    def _evcmd_show_balloon(*a, &b);               _evcmd(CODE_SHOW_BALLOON, indent, a); end
    def _evcmd_erase_event(*a, &b);                _evcmd(CODE_ERASE_EVENT, indent, a); end
    def _evcmd_set_followers_visiblity(*a, &b);    _evcmd(CODE_SET_FOLLOWERS_VISIBLITY, indent, a); end
    def _evcmd_gather_followers(*a, &b);           _evcmd(CODE_GATHER_FOLLOWERS, indent, a); end
    def _evcmd_screen_fadeout(*a, &b);             _evcmd(CODE_SCREEN_FADEOUT, indent, a); end
    def _evcmd_screen_fadein(*a, &b);              _evcmd(CODE_SCREEN_FADEIN, indent, a); end
    def _evcmd_screen_tint(*a, &b);                _evcmd(CODE_SCREEN_TINT, indent, a); end
    def _evcmd_screen_flash(*a, &b);               _evcmd(CODE_SCREEN_FLASH, indent, a); end
    def _evcmd_screen_shake(*a, &b);               _evcmd(CODE_SCREEN_SHAKE, indent, a); end
    def _evcmd_wait(*a, &b);                       _evcmd(CODE_WAIT, indent, a); end
    def _evcmd_show_picture(*a, &b);               _evcmd(CODE_SHOW_PICTURE, indent, a); end
    def _evcmd_move_picture(*a, &b);               _evcmd(CODE_MOVE_PICTURE, indent, a); end
    def _evcmd_rotate_picture(*a, &b);             _evcmd(CODE_ROTATE_PICTURE, indent, a); end
    def _evcmd_tint_picture(*a, &b);               _evcmd(CODE_TINT_PICTURE, indent, a); end
    def _evcmd_erase_picture(*a, &b);              _evcmd(CODE_ERASE_PICTURE, indent, a); end
    def _evcmd_set_weather(*a, &b);                _evcmd(CODE_SET_WEATHER, indent, a); end
    def _evcmd_bgm_play(*a, &b);                   _evcmd(CODE_BGM_PLAY, indent, a); end
    def _evcmd_bgm_fadeout(*a, &b);                _evcmd(CODE_BGM_FADEOUT, indent, a); end
    def _evcmd_bgm_save(*a, &b);                   _evcmd(CODE_BGM_SAVE, indent, a); end
    def _evcmd_bgm_resume(*a, &b);                 _evcmd(CODE_BGM_RESUME, indent, a); end
    def _evcmd_bgs_play(*a, &b);                   _evcmd(CODE_BGS_PLAY, indent, a); end
    def _evcmd_bgs_fadeout(*a, &b);                _evcmd(CODE_BGS_FADEOUT, indent, a); end
    def _evcmd_me_play(*a, &b);                    _evcmd(CODE_ME_PLAY, indent, a); end
    def _evcmd_se_play(*a, &b);                    _evcmd(CODE_SE_PLAY, indent, a); end
    def _evcmd_se_stop(*a, &b);                    _evcmd(CODE_SE_STOP, indent, a); end
    def _evcmd_movie_play(*a, &b);                 _evcmd(CODE_MOVIE_PLAY, indent, a); end
    def _evcmd_set_map_name_display(*a, &b);       _evcmd(CODE_SET_MAP_NAME_DISPLAY, indent, a); end
    def _evcmd_change_tileset(*a, &b);             _evcmd(CODE_CHANGE_TILESET, indent, a); end
    def _evcmd_change_battle_background(*a, &b);   _evcmd(CODE_CHANGE_BATTLE_BACKGROUND, indent, a); end
    def _evcmd_change_parallax_background(*a, &b); _evcmd(CODE_CHANGE_PARALLAX_BACKGROUND, indent, a); end
    def _evcmd_get_location_info(*a, &b);          _evcmd(CODE_GET_LOCATION_INFO, indent, a); end
    def _evcmd_process_battle(*a, &b);             _evcmd(CODE_PROCESS_BATTLE, indent, a); end
    def _evcmd_battle_branch_win(*a, &b);          _evcmd(CODE_BATTLE_BRANCH_WIN, indent, a); end
    def _evcmd_battle_branch_escape(*a, &b);       _evcmd(CODE_BATTLE_BRANCH_ESCAPE, indent, a); end
    def _evcmd_battle_branch_lose(*a, &b);         _evcmd(CODE_BATTLE_BRANCH_LOSE, indent, a); end
    def _evcmd_process_shop(*a, &b);               _evcmd(CODE_PROCESS_SHOP, indent, a); end
    def _evcmd_shop_item(*a, &b);                  _evcmd(CODE_SHOP_ITEM, indent, a); end
    def _evcmd_process_name_input(*a, &b);         _evcmd(CODE_PROCESS_NAME_INPUT, indent, a); end
    def _evcmd_process_menu(*a, &b);               _evcmd(CODE_PROCESS_MENU, indent, a); end
    def _evcmd_process_save(*a, &b);               _evcmd(CODE_PROCESS_SAVE, indent, a); end
    def _evcmd_process_gameover(*a, &b);           _evcmd(CODE_PROCESS_GAMEOVER, indent, a); end
    def _evcmd_process_title(*a, &b);              _evcmd(CODE_PROCESS_TITLE, indent, a); end
    def _evcmd_change_actor_hp(*a, &b);            _evcmd(CODE_CHANGE_ACTOR_HP, indent, a); end
    def _evcmd_change_actor_mp(*a, &b);            _evcmd(CODE_CHANGE_ACTOR_MP, indent, a); end
    def _evcmd_change_actor_state(*a, &b);         _evcmd(CODE_CHANGE_ACTOR_STATE, indent, a); end
    def _evcmd_actor_recover_all(*a, &b);          _evcmd(CODE_ACTOR_RECOVER_ALL, indent, a); end
    def _evcmd_change_actor_exp(*a, &b);           _evcmd(CODE_CHANGE_ACTOR_EXP, indent, a); end
    def _evcmd_change_actor_level(*a, &b);         _evcmd(CODE_CHANGE_ACTOR_LEVEL, indent, a); end
    def _evcmd_change_actor_parameters(*a, &b);    _evcmd(CODE_CHANGE_ACTOR_PARAMETERS, indent, a); end
    def _evcmd_change_actor_skill(*a, &b);         _evcmd(CODE_CHANGE_ACTOR_SKILL, indent, a); end
    def _evcmd_change_actor_equip(*a, &b);         _evcmd(CODE_CHANGE_ACTOR_EQUIP, indent, a); end
    def _evcmd_change_actor_name(*a, &b);          _evcmd(CODE_CHANGE_ACTOR_NAME, indent, a); end
    def _evcmd_change_actor_class(*a, &b);         _evcmd(CODE_CHANGE_ACTOR_CLASS, indent, a); end
    def _evcmd_change_actor_graphic(*a, &b);       _evcmd(CODE_CHANGE_ACTOR_GRAPHIC, indent, a); end
    def _evcmd_change_vehicle_graphic(*a, &b);     _evcmd(CODE_CHANGE_VEHICLE_GRAPHIC, indent, a); end
    def _evcmd_change_actor_nickname(*a, &b);      _evcmd(CODE_CHANGE_ACTOR_NICKNAME, indent, a); end
    def _evcmd_change_enemy_hp(*a, &b);            _evcmd(CODE_CHANGE_ENEMY_HP, indent, a); end
    def _evcmd_change_enemy_mp(*a, &b);            _evcmd(CODE_CHANGE_ENEMY_MP, indent, a); end
    def _evcmd_change_enemy_state(*a, &b);         _evcmd(CODE_CHANGE_ENEMY_STATE, indent, a); end
    def _evcmd_enemy_recover_all(*a, &b);          _evcmd(CODE_ENEMY_RECOVER_ALL, indent, a); end
    def _evcmd_enemy_appear(*a, &b);               _evcmd(CODE_ENEMY_APPEAR, indent, a); end
    def _evcmd_enemy_transform(*a, &b);            _evcmd(CODE_ENEMY_TRANSFORM, indent, a); end
    def _evcmd_show_battle_animation(*a, &b);      _evcmd(CODE_SHOW_BATTLE_ANIMATION, indent, a); end
    def _evcmd_battle_force_action(*a, &b);        _evcmd(CODE_BATTLE_FORCE_ACTION, indent, a); end
    def _evcmd_battle_abort(*a, &b);               _evcmd(CODE_BATTLE_ABORT, indent, a); end
    def _evcmd_script(*a, &b);                     _evcmd(CODE_SCRIPT, indent, a); end
    def _evcmd_script_text(*a, &b);                _evcmd(CODE_SCRIPT_TEXT, indent, a); end
    def _evcmd_if(*a, &b);                         _branch(*a, &b); end
    def _evcmd_transfer_player(*a, &b);            _position(*a, &b); end
    def _evcmd_eval(*a, &b);                       _script(*a, &b); end

    # _evcmd_null
    def nocmd
      _evcmd_null
    end
    alias :null :nocmd

    # _evcmd_show_text
    # _evcmd_text
    def show_text(face_name, face_index, background, position, strs = [])
      _evcmd_show_text face_name, face_index, background, position
      strs.each { |str| _evcmd_text str }
    end

    def text(str)
      _evcmd_text str
    end

    def show_text_h(opts)
      face_name  = ""
      face_index = 0
      background = ""
      position   = 2
      texts = []
      case opts
      when Array
        texts = opts
      when String
        texts = [opts]
      when Hash
        face_name  = opts[:face_name]  || face_name
        face_index = opts[:face_index] || face_index
        background = opts[:background] || background
        position   = opts[:position]   || position
        texts      = opts.fetch(:texts)
      else
        raise TypeError,
              "wrong argument type #{ops.class} (expected Array, Hash, or String)"
      end
      show_text face_name, face_index, background, position, texts
    end

    # _evcmd_show_choice
    # _evcmd_choice_branch
    # _evcmd_choice_cancel
    # _evcmd_choice_end
    def show_choice(choices, cancel_type)
      _evcmd_show_choice(choices, cancel_type)
    end

    def choice_branch(index, str)
      _evcmd_choice_branch index, str
    end

    def show_choice_h(opts)
      choices = opts.fetch(:choices).map(&:to_s)
      cancel_type = opts[:cancel_type] || 0
      show_choice choices, cancel_type
      choices.each_with_index do |str, index|
        choice_branch index, str
        _inc_indent do
          yield str, index
          nocmd
        end
      end
      #if cancel_type > 0
      #  _evcmd_choice_cancel
      #  _evcmd_null
      #end
      choice_end
    end
    alias :choice :show_choice

    # _evcmd_show_num_input
    def show_number_input(variable_id, digits_max)
      _evcmd_show_num_input variable_id, digits_max
    end
    alias :show_num_input :show_number_input
    alias :num_input :show_number_input

    # _evcmd_show_item_choice
    def show_item_choice(variable_id)
      _evcmd_show_item_choice variable_id
    end
    alias :item_choice :show_item_choice

    # _evcmd_show_text_scrolling
    # _evcmd_text_scrolling
    def show_text_scrolling(opts)
      speed = opts[:speed] || 5
      fast_scroll = opts[:fast_scroll]
      texts = opts.fetch(texts)
      _evcmd_show_text_scrolling speed, !fast_scroll
      texts.each { |str| _evcmd_text_scrolling str }
    end
    alias :scrolling_text :show_text_scrolling

    # _evcmd_comment
    # _evcmd_comment_text
    def comment(*comments)
      first = comments.pop
      _evcmd_comment first
      comments.each { |str| _evcmd_comment_text str }
    end

    # _evcmd_conditional_branch
    # _evcmd_conditional_branch_else
    # _evcmd_conditional_branch_end
    def conditional_branch_end
      _evcmd_conditional_branch_end
    end

    def conditional_branch_else
      _evcmd_conditional_branch_else
    end

    def conditional_branch(*args)
      _evcmd_conditional_branch(*args)
    end

    def conditional_branch_switch(*args)
      conditional_branc(CONDITIONAL_BRANCH_TYPE_SWITCH, *args)
    end

    def conditional_branch_variable(*args)
      conditional_branc(CONDITIONAL_BRANCH_TYPE_VARIABLE, *args)
    end

    def conditional_branch_self_switch(*args)
      conditional_branc(CONDITIONAL_BRANCH_TYPE_SELF_SWITCH, *args)
    end

    def conditional_branch_timer(*args)
      conditional_branc(CONDITIONAL_BRANCH_TYPE_TIMER, *args)
    end

    def conditional_branch_actor(*args)
      conditional_branc(CONDITIONAL_BRANCH_TYPE_ACTOR, *args)
    end

    def conditional_branch_enemy(*args)
      conditional_branc(CONDITIONAL_BRANCH_TYPE_ENEMY, *args)
    end

    def conditional_branch_character(*args)
      conditional_branc(CONDITIONAL_BRANCH_TYPE_CHARACTER, *args)
    end

    def conditional_branch_gold(*args)
      conditional_branc(CONDITIONAL_BRANCH_TYPE_GOLD, *args)
    end

    def conditional_branch_item(*args)
      conditional_branc(CONDITIONAL_BRANCH_TYPE_ITEM, *args)
    end

    def conditional_branch_weapon(*args)
      conditional_branc(CONDITIONAL_BRANCH_TYPE_WEAPON, *args)
    end

    def conditional_branch_armor(*args)
      conditional_branc(CONDITIONAL_BRANCH_TYPE_ARMOR, *args)
    end

    def conditional_branch_button(*args)
      conditional_branc(CONDITIONAL_BRANCH_TYPE_BUTTON, *args)
    end

    def conditional_branch_script(*args)
      conditional_branc(CONDITIONAL_BRANCH_TYPE_SCRIPT, *args)
    end

    def conditional_branch_vehicle(*args)
      conditional_branc(CONDITIONAL_BRANCH_TYPE_VEHICLE, *args)
    end

    # _evcmd_loop
    # _evcmd_repeat
    def eloop
      _evcmd_loop
      _inc_indent do
        yield
        nocmd
      end
      _evcmd_repeat
    end

    def choice_end
      _evcmd_choice_end
    end

    def branch_end
      _evcmd_branch_end
    end

    def erepeat
      _evcmd_repeat
    end

    # _evcmd_break
    def ebreak
      _evcmd_break
    end

    # _evcmd_terminate
    def terminate
      _evcmd_terminate
    end

    # _evcmd_call_common_event
    def call_common_event(common_event_id)
      _evcmd_call_common_event common_event_id.to_i
    end

    # _evcmd_label
    def label(labelname)
      _evcmd_label labelname.to_s
    end

    # _evcmd_jump_to_label
    def jump_to_label(labelname)
      _evcmd_jump_to_label labelname.to_s
    end

    # _evcmd_control_switch
    def control_switch(id_or_range, bool)
      if id_or_range.is_a?(Range)
        _evcmd_control_switch id_or_range.first, id_or_range.last, bool
      else
        _evcmd_control_switch id_or_range, id_or_range, bool
      end
    end

    # _evcmd_control_variable
    def control_variable(id_or_range, operation, operand_type, *args)
      if id_or_range.is_a?(Range)
        first, last = id_or_range.first, id_or_range.last
      else
        first, last = id_or_range, id_or_range
      end
      _evcmd_control_variable first.to_i, last.to_i,
                              operation.to_i, operand_type.to_i, *args
    end

    def control_variable_i(id_or_range, operation, value)
      control_variable(id_or_range, operation, VARIABLE_OPERAND_TYPE_INT, value)
    end

    def control_variable_var(id_or_range, operation, variable_id)
      control_variable(id_or_range, operation, VARIABLE_OPERAND_TYPE_VARIABLE, variable_id.to_i)
    end

    def control_variable_rand(id_or_range, operation, floor, cap)
      control_variable(id_or_range, operation, VARIABLE_OPERAND_TYPE_RANDOM, floor.to_i, cap.to_i)
    end

    def control_variable_game_data(id_or_range, operation, type, *args)
      control_variable(id_or_range, operation, VARIABLE_OPERAND_TYPE_GAME_DATA, type.to_i, *args)
    end

    def control_variable_gmd_item_count(id_or_range, operation, item_id)
      control_variable_game_data(id_or_range, operation, 0, item_id.to_i)
    end

    def control_variable_gmd_weapon_count(id_or_range, operation, weapon_id)
      control_variable_game_data(id_or_range, operation, 1, weapon_id.to_i)
    end

    def control_variable_gmd_armor_count(id_or_range, operation, armor_id)
      control_variable_game_data(id_or_range, operation, 2, armor_id.to_i)
    end

    def control_variable_gmd_actor_attr(id_or_range, operation, actor_id, param_id)
      control_variable_game_data(id_or_range, operation, 3, actor_id.to_i, param_id.to_i)
    end

    def control_variable_gmd_actor_level(id_or_range, operation, actor_id)
      control_variable_gmd_actor_attr(id_or_range, operation, actor_id.to_i, 0)
    end

    def control_variable_gmd_actor_exp(id_or_range, operation, actor_id)
      control_variable_gmd_actor_attr(id_or_range, operation, actor_id.to_i, 1)
    end

    def control_variable_gmd_actor_hp(id_or_range, operation, actor_id)
      control_variable_gmd_actor_attr(id_or_range, operation, actor_id.to_i, 2)
    end

    def control_variable_gmd_actor_mp(id_or_range, operation, actor_id)
      control_variable_gmd_actor_attr(id_or_range, operation, actor_id.to_i, 3)
    end

    def control_variable_gmd_actor_mhp(id_or_range, operation, actor_id)
      control_variable_gmd_actor_attr(id_or_range, operation, actor_id.to_i, 4)
    end

    def control_variable_gmd_actor_mmp(id_or_range, operation, actor_id)
      control_variable_gmd_actor_attr(id_or_range, operation, actor_id.to_i, 5)
    end

    def control_variable_gmd_actor_atk(id_or_range, operation, actor_id)
      control_variable_gmd_actor_attr(id_or_range, operation, actor_id.to_i, 6)
    end

    def control_variable_gmd_actor_def(id_or_range, operation, actor_id)
      control_variable_gmd_actor_attr(id_or_range, operation, actor_id.to_i, 7)
    end

    def control_variable_gmd_actor_mat(id_or_range, operation, actor_id)
      control_variable_gmd_actor_attr(id_or_range, operation, actor_id.to_i, 8)
    end

    def control_variable_gmd_actor_mdf(id_or_range, operation, actor_id)
      control_variable_gmd_actor_attr(id_or_range, operation, actor_id.to_i, 9)
    end

    def control_variable_gmd_actor_agi(id_or_range, operation, actor_id)
      control_variable_gmd_actor_attr(id_or_range, operation, actor_id.to_i, 10)
    end

    def control_variable_gmd_actor_luk(id_or_range, operation, actor_id)
      control_variable_gmd_actor_attr(id_or_range, operation, actor_id.to_i, 11)
    end

    def control_variable_gmd_enemy_attr(id_or_range, operation, enemy_id, param_id)
      control_variable_game_data(id_or_range, operation, 4, enemy_id.to_i, param_id.to_i)
    end

    def control_variable_gmd_enemy_hp(id_or_range, operation, enemy_id)
      control_variable_gmd_enemy_attr(id_or_range, operation, enemy_id.to_i, 0)
    end

    def control_variable_gmd_enemy_mp(id_or_range, operation, enemy_id)
      control_variable_gmd_enemy_attr(id_or_range, operation, enemy_id.to_i, 1)
    end

    def control_variable_gmd_enemy_mhp(id_or_range, operation, enemy_id)
      control_variable_gmd_enemy_attr(id_or_range, operation, enemy_id.to_i, 2)
    end

    def control_variable_gmd_enemy_mmp(id_or_range, operation, enemy_id)
      control_variable_gmd_enemy_attr(id_or_range, operation, enemy_id.to_i, 3)
    end

    def control_variable_gmd_enemy_atk(id_or_range, operation, enemy_id)
      control_variable_gmd_enemy_attr(id_or_range, operation, enemy_id.to_i, 4)
    end

    def control_variable_gmd_enemy_def(id_or_range, operation, enemy_id)
      control_variable_gmd_enemy_attr(id_or_range, operation, enemy_id.to_i, 5)
    end

    def control_variable_gmd_enemy_mat(id_or_range, operation, enemy_id)
      control_variable_gmd_enemy_attr(id_or_range, operation, enemy_id.to_i, 6)
    end

    def control_variable_gmd_enemy_mdf(id_or_range, operation, enemy_id)
      control_variable_gmd_enemy_attr(id_or_range, operation, enemy_id.to_i, 7)
    end

    def control_variable_gmd_enemy_agi(id_or_range, operation, enemy_id)
      control_variable_gmd_enemy_attr(id_or_range, operation, enemy_id.to_i, 8)
    end

    def control_variable_gmd_enemy_luk(id_or_range, operation, enemy_id)
      control_variable_gmd_enemy_attr(id_or_range, operation, enemy_id.to_i, 9)
    end

    def control_variable_gmd_character_attr(id_or_range, operation, character_id, param_id)
      control_variable_game_data(id_or_range, operation, 5, character_id.to_i, param_id.to_i)
    end

    def control_variable_gmd_character_x(id_or_range, operation, character_id)
      control_variable_gmd_character_attr id_or_range, operation, character_id, 0
    end

    def control_variable_gmd_character_y(id_or_range, operation, character_id)
      control_variable_gmd_character_attr id_or_range, operation, character_id, 1
    end

    def control_variable_gmd_character_direction(id_or_range, operation, character_id)
      control_variable_gmd_character_attr id_or_range, operation, character_id, 2
    end

    def control_variable_gmd_character_screen_x(id_or_range, operation, character_id)
      control_variable_gmd_character_attr id_or_range, operation, character_id, 3
    end

    def control_variable_gmd_character_screen_y(id_or_range, operation, character_id)
      control_variable_gmd_character_attr id_or_range, operation, character_id, 4
    end

    def control_variable_gmd_party_member_id(id_or_range, operation, party_member_index)
      control_variable_game_data(id_or_range, operation, 6, party_member_index.to_i)
    end

    def control_variable_gmd_other(id_or_range, operation, param_id)
      control_variable_game_data(id_or_range, operation, 7, param_id.to_i)
    end

    def control_variable_gmd_map_id(id_or_range, operation)
      control_variable_gmd_other id_or_range, operation, 0
    end

    def control_variable_gmd_party_member_count(id_or_range, operation)
      control_variable_gmd_other id_or_range, operation, 1
    end

    def control_variable_gmd_gold(id_or_range, operation)
      control_variable_gmd_other id_or_range, operation, 2
    end

    def control_variable_gmd_steps(id_or_range, operation)
      control_variable_gmd_other id_or_range, operation, 3
    end

    def control_variable_gmd_playtime(id_or_range, operation)
      control_variable_gmd_other id_or_range, operation, 4
    end

    def control_variable_gmd_timer(id_or_range, operation)
      control_variable_gmd_other id_or_range, operation, 5
    end

    def control_variable_gmd_save_count(id_or_range, operation)
      control_variable_gmd_other id_or_range, operation, 6
    end

    def control_variable_gmd_battle_count(id_or_range, operation)
      control_variable_gmd_other id_or_range, operation, 7
    end

    def control_variable_script(id_or_range, operation, str)
      control_variable id_or_range, operation, VARIABLE_OPERAND_TYPE_SCRIPT, String(str)
    end

    def _obj_to_nbool(obj)
      Integer === obj ? obj : ((!!obj) ? 0 : 1)
    end

    # _evcmd_control_self_switch
    def control_self_switch(self_switch_id, bool)
      _evcmd_control_self_switch self_switch_id.to_s, _obj_to_nbool(bool)
    end

    # _evcmd_control_timer
    def control_timer(start, time = 0)
      _evcmd_control_timer _obj_to_nbool(start), time.to_i
    end

    # _evcmd_change_gold
    def change_gold(operation, operand_type, operand)
      _evcmd_change_gold(operation.to_i, operand_type.to_i, operand.to_i)
    end

    def change_gold_i(operation, value)
      change_gold operation, 0, value
    end

    def change_gold_var(operation, variable_id)
      change_gold operation, 1, variable_id
    end

    def increase_gold(operand_type, value)
      change_gold 0, operand_type, value
    end

    def decrease_gold(operand_type, value)
      change_gold 1, operand_type, value
    end

    def increase_gold_i(value)
      change_gold_i 0, value
    end

    def decrease_gold_i(value)
      change_gold_i 1, value
    end

    def increase_gold_var(variable_id)
      change_gold_var 0, variable_id
    end

    def decrease_gold_var(variable_id)
      change_gold_var 1, variable_id
    end

    # _evcmd_change_item
    def change_item(item_id, operation, operand_type, operand)
      _evcmd_change_item item_id.to_i, operation.to_i, operand_type.to_i, operand.to_i
    end

    def change_item_i(item_id, operation, value)
      change_item item_id, operation, 0, value
    end

    def change_item_var(item_id, operation, variable_id)
      change_item item_id, operation, 1, variable_id
    end

    def increase_item(item_id, operand_type, value)
      change_item item_id, 0, operand_type, value
    end

    def decrease_item(item_id, operand_type, value)
      change_item item_id, 1, operand_type, value
    end

    def increase_item_i(item_id, value)
      change_item_i item_id, 0, value
    end

    def decrease_item_i(item_id, value)
      change_item_i item_id, 1, value
    end

    def increase_item_var(item_id, variable_id)
      change_item_var item_id, 0, variable_id
    end

    def decrease_item_var(item_id, variable_id)
      change_item_var item_id, 1, variable_id
    end

    # _evcmd_change_weapon
    def change_weapon(weapon_id, operation, operand_type, operand, check_equipped = false)
      _evcmd_change_weapon weapon_id.to_i, operation.to_i, operand_type.to_i, operand.to_i, check_equipped
    end

    def change_weapon_i(weapon_id, operation, value, check_equipped = false)
      change_weapon(weapon_id, operation, 0, value, check_equipped)
    end

    def change_weapon_var(weapon_id, operation, variable_id, check_equipped = false)
      change_weapon(weapon_id, operation, 1, variable_id, check_equipped)
    end

    def increase_weapon(weapon_id, operand_type, value, check_equipped = false)
      change_weapon(weapon_id, 0, operand_type, value, check_equipped)
    end

    def decrease_weapon(weapon_id, operand_type, value, check_equipped = false)
      change_weapon(weapon_id, 1, operand_type, value, check_equipped)
    end

    def increase_weapon_i(weapon_id, value, check_equipped = false)
      change_weapon_i(weapon_id, 0, value, check_equipped)
    end

    def decrease_weapon_i(weapon_id, value, check_equipped = false)
      change_weapon_i(weapon_id, 1, value, check_equipped)
    end

    def increase_weapon_var(weapon_id, variable_id, check_equipped = false)
      change_weapon_var(weapon_id, 0, variable_id, check_equipped)
    end

    def decrease_weapon_var(weapon_id, variable_id, check_equipped = false)
      change_weapon_var(weapon_id, 1, variable_id, check_equipped)
    end

    # _evcmd_change_armor
    def change_armor(armor_id, operation, operand_type, operand, check_equipped = false)
      _evcmd_change_armor(armor_id.to_i, operation.to_i, operand_type.to_i, operand.to_i, check_equipped)
    end

    def change_armor_i(armor_id, operation, value, check_equipped = false)
      change_armor(armor_id, operation, 0, value, check_equipped)
    end

    def change_armor_var(armor_id, operation, variable_id, check_equipped = false)
      change_armor(armor_id, operation, 1, variable_id, check_equipped)
    end

    def increase_armor(armor_id, operand_type, value, check_equipped = false)
      change_armor(armor_id, 0, operand_type, value, check_equipped)
    end

    def decrease_armor(armor_id, operand_type, value, check_equipped = false)
      change_armor(armor_id, 1, operand_type, value, check_equipped)
    end

    def increase_armor_i(armor_id, value, check_equipped = false)
      change_armor_i(armor_id, 0, value, check_equipped)
    end

    def decrease_armor_i(armor_id, value, check_equipped = false)
      change_armor_i(armor_id, 1, value, check_equipped)
    end

    def increase_armor_var(armor_id, variable_id, check_equipped = false)
      change_armor_var(armor_id, 0, variable_id, check_equipped)
    end

    def decrease_armor_var(armor_id, variable_id, check_equipped = false)
      change_armor_var(armor_id, 1, variable_id, check_equipped)
    end

    # _evcmd_change_party_member
    def change_party_member(operation, actor_id)
      _evcmd_change_party_member(armor_id, operation.to_i, actor_id.to_i)
    end

    def add_party_member(actor_id)
      change_party_member(armor_id, 0, actor_id)
    end

    def remove_party_member(actor_id)
      change_party_member(1, actor_id)
    end

    # _evcmd_change_battle_bgm
    def change_battle_bgm(filename, volume = 100, pitch = 100)
      _evcmd_change_battle_bgm RPG::BGM.new(filename, volume, pitch)
    end

    # _evcmd_change_battle_end_me
    def change_battle_end_me(filename, volume = 100, pitch = 100)
      _evcmd_change_battle_end_me RPG::ME.new(filename, volume, pitch)
    end

    # _evcmd_change_save_access
    def change_save_access(bool)
      _evcmd_change_save_access bool ? 0 : 1
    end

    # _evcmd_change_menu_access
    def change_menu_access(bool)
      _evcmd_change_menu_access bool ? 0 : 1
    end

    # _evcmd_change_encounter
    def change_encounter(bool)
      _evcmd_change_encounter bool ? 0 : 1
    end

    # _evcmd_change_formation_access
    def change_formation_access(bool)
      _evcmd_change_formation_access bool ? 0 : 1
    end

    # _evcmd_change_window_tone
    def change_window_tone(r, g, b, gray)
      _evcmd_change_window_tone Tone.new(r, g, b, gray)
    end

    # _evcmd_set_player_position
    def set_player_position(operand_type, map_id, p1, p2, dir = 2, fade_type = 0)
      _evcmd_set_player_position operand_type.to_i, map_id.to_i, p1.to_i, p2.to_i, dir.to_i, fade_type
    end

    def set_player_position_xy(map_id, x, y, dir = 2, fade_type = 0)
      set_player_position 0, map_id, x, y, dir, fade_type
    end

    def set_player_position_var(map_id, v1, v2, dir = 2, fade_type = 0)
      set_player_position 1, map_id, v1, v2, dir, fade_type
    end

    # _evcmd_set_vehicle_position
    def set_vehicle_position(vehicle_id, operand_type, p1, p2, p3)
      _evcmd_set_vehicle_position(vehicle_id, operand_type, p1, p2, p3)
    end

    def set_vehicle_position_xy(vehicle_id, map_id, x, y)
      set_vehicle_position(vehicle_id, 0, map_id, x, y)
    end

    def set_vehicle_position_var(vehicle_id, v1, v2, v3)
      set_vehicle_position(vehicle_id, 1, v1, v2, v3)
    end

    # _evcmd_set_event_position
    def set_event_position(char_id, operand_type, p1, p2, direction)
      _evcmd_set_event_position(char_id, operand_type, p1, p2, direction)
    end

    def set_event_position_xy(char_id, x, y, direction)
      set_event_position(char_id, 0, x, y, direction)
    end

    def set_event_position_var(char_id, v1, v2, direction)
      set_event_position(char_id, 1, v1, v2, direction)
    end

    def set_event_position_char(char_id, char_id2, direction)
      set_event_position(char_id, 2, char_id2, nil, direction)
    end

    # _evcmd_scroll_map
    def scroll_map(direction, distance, speed)
      _evcmd_scroll_map(direction, distance, speed)
    end

    # _evcmd_set_move_route
    def set_move_route(char_id, move_route)
      _evcmd_set_move_route(char_id, move_route)
    end

    def move_route
      move_route = MoveRouteBuilder.new
      yield move_route
      move_route.render
    end

    def move_command(move_command)
      _evcmd_move_command(move_command)
    end

    # _evcmd_get_on_off_vehicle
    def get_on_off_vehicle
      _evcmd_get_on_off_vehicle
    end

    # _evcmd_change_transperency
    def change_transperency(bool)
      _evcmd_change_transperency(bool ? 0 : 1)
    end

    # _evcmd_show_animation
    def show_animation(character_id, animation_id, should_wait=false)
      _evcmd_show_animation(character_id.to_i, animation_id.to_i, !!should_wait)
    end

    # _evcmd_show_balloon
    def show_balloon(character_id, balloon_id, should_wait=false)
      _evcmd_show_balloon(character_id.to_i, balloon_id.to_i, !!should_wait)
    end

    # _evcmd_erase_event
    def erase_event
      _evcmd_erase_event
    end

    # _evcmd_set_followers_visiblity
    def set_followers_visiblity(bool)
      _evcmd_set_followers_visiblity(!!bool)
    end

    # _evcmd_gather_followers
    def gather_followers
      _evcmd_gather_followers
    end

    # _evcmd_screen_fadeout
    def screen_fadeout
      _evcmd_screen_fadeout
    end

    # _evcmd_screen_fadein
    def screen_fadein
      _evcmd_screen_fadein
    end

    # _evcmd_screen_tint
    def screen_tint(tone, time, wait)
      _evcmd_screen_tint(tone, time, !!wait)
    end

    def screen_tint_async(tone, time)
      screen_tint(tone, time, false)
    end

    def screen_tint_sync(tone, time)
      screen_tint(tone, time, true)
    end

    # _evcmd_screen_flash
    def screen_flash(color, time, wait)
      _evcmd_screen_flash(color, time, !!wait)
    end

    def screen_flash_async(color, time)
      screen_flash(color, time, false)
    end

    def screen_flash_sync(color, time)
      screen_flash(color, time, true)
    end

    # _evcmd_screen_shake
    def screen_shake(power, speed, time, wait)
      _evcmd_screen_shake(power, speded, time, !!wait)
    end

    def screen_shake_async(power, speed, time)
      screen_shake(power, speed, time, false)
    end

    def screen_shake_sync(power, speed, time)
      screen_shake(power, speed, time, true)
    end

    # _evcmd_wait
    def wait(n)
      _evcmd_wait(n.to_i)
    end

    # _evcmd_show_picture
    def show_picture(picture_id, name, origin, pos_code, p1, p2, zoom_x, zoom_y, opacity, blend_type)
      _evcmd_show_picture(picture_id, name, origin, pos_code, p1, p2, zoom_x, zoom_y, opacity, blend_type)
    end

    def show_picture_xy(picture_id, name, origin, x, y, zoom_x, zoom_y, opacity, blend_type)
      show_picture(picture_id, name, origin, 0, x, y, zoom_x, zoom_y, opacity, blend_type)
    end

    def show_picture_var(picture_id, name, origin, v1, v2, zoom_x, zoom_y, opacity, blend_type)
      show_picture(picture_id, name, origin, 1, v1, v2, zoom_x, zoom_y, opacity, blend_type)
    end

    # _evcmd_move_picture
    def move_picture(picture_id, name, origin, pos_code, p1, p2, zoom_x, zoom_y, opacity, blend_type, duration, wait)
      _evcmd_move_picture(picture_id, name, origin, pos_code, p1, p2, zoom_x, zoom_y, opacity, blend_type, duration, !!wait)
    end

    def move_picture_xy(picture_id, name, origin, x, y, zoom_x, zoom_y, opacity, blend_type, duration, wait)
      move_picture(picture_id, name, origin, 0, x, y, zoom_x, zoom_y, opacity, blend_type, duration, wait)
    end

    def move_picture_xy_aysnc(picture_id, name, origin, x, y, zoom_x, zoom_y, opacity, blend_type, duration)
      move_picture_xy(picture_id, name, origin, x, y, zoom_x, zoom_y, opacity, blend_type, duration, false)
    end

    def move_picture_xy_sync(picture_id, name, origin, x, y, zoom_x, zoom_y, opacity, blend_type, duration)
      move_picture_xy(picture_id, name, origin, x, y, zoom_x, zoom_y, opacity, blend_type, duration, true)
    end

    def move_picture_var(picture_id, name, origin, v1, v2, zoom_x, zoom_y, opacity, blend_type, duration, wait)
      move_picture(picture_id, name, origin, 1, v1, v2, zoom_x, zoom_y, opacity, blend_type, duration, wait)
    end

    def move_picture_var_async(picture_id, name, origin, v1, v2, zoom_x, zoom_y, opacity, blend_type, duration)
      move_picture_var(picture_id, name, origin, v1, v2, zoom_x, zoom_y, opacity, blend_type, duration, false)
    end

    def move_picture_var_sync(picture_id, name, origin, v1, v2, zoom_x, zoom_y, opacity, blend_type, duration)
      move_picture_var(picture_id, name, origin, v1, v2, zoom_x, zoom_y, opacity, blend_type, duration, true)
    end

    # _evcmd_rotate_picture
    def rotate_picture(picture_id, angle)
      _evcmd_rotate_picture(picture_id, angle)
    end

    # _evcmd_tint_picture
    def tint_picture(picture_id, tone, duration, wait)
      _evcmd_tint_picture(picture_id, tone, duration, !!wait)
    end

    def tint_picture_async(picture_id, tone, duration)
      tint_picture(picture_id, tone, duration, false)
    end

    def tint_picture_sync(picture_id, tone, duration)
      tint_picture(picture_id, tone, duration, true)
    end

    # _evcmd_erase_picture
    def erase_picture(picture_id)
      _evcmd_erase_picture(picture_id)
    end

    # _evcmd_set_weather
    def set_weather(type, power, duration, wait)
      _evcmd_set_weather(type, power, duration, !!wait)
    end

    def set_weather_async(type, power, duration)
      set_weather(type, power, duration, false)
    end

    def set_weather_sync(type, power, duration)
      set_weather(type, power, duration, true)
    end

    # _evcmd_bgm_play
    def bgm_play(filename, volume = 100, pitch = 100)
      _evcmd_bgm_play(RPG::BGM.new(filename, volume, pitch))
    end
    alias :play_bgm :bgm_play

    # _evcmd_bgm_fadeout
    def bgm_fadeout(seconds)
      _evcmd_bgm_fadeout(seconds)
    end

    # _evcmd_bgm_save
    def bgm_save
      _evcmd_bgm_save
    end
    alias :save_bgm :bgm_save

    # _evcmd_bgm_resume
    def bgm_resume
      _evcmd_bgm_resume
    end
    alias :resume_bgm :bgm_resume

    # _evcmd_bgs_play
    def bgs_play(filename, volume = 100, pitch = 100)
      _evcmd_bgs_play(RPG::BGS.new(filename, volume, pitch))
    end
    alias :play_bgs :bgs_play

    # _evcmd_bgs_fadeout
    def bgs_fadeout(seconds)
      _evcmd_bgs_fadeout(seconds)
    end

    # _evcmd_me_play
    def me_play(filename, volume = 100, pitch = 100)
      _evcmd_me_play(RPG::ME.new(filename, volume, pitch))
    end
    alias :play_me :me_play

    # _evcmd_se_play
    def se_play(filename, volume = 100, pitch = 100)
      _evcmd_se_play(RPG::SE.new(filename, volume, pitch))
    end
    alias :play_se :se_play

    # _evcmd_se_stop
    def se_stop
      _evcmd_se_stop
    end
    alias :stop_se :se_stop

    # _evcmd_movie_play
    def movie_play(filename)
      _evcmd_movie_play(filename)
    end
    alias :play_movie :movie_play

    # _evcmd_set_map_name_display
    def set_map_name_display
      _evcmd_set_map_name_display(bool ? 0 : 1)
    end
    alias :toggle_map_name_display :set_map_name_display

    # _evcmd_change_tileset
    def change_tileset(tileset_id)
      _evcmd_change_tileset(tileset_id.to_i)
    end

    # _evcmd_change_battle_background
    def change_battle_background(top_filename, bottom_filename)
      _evcmd_change_battle_background(String(top_filename),
                                      String(bottom_filename))
    end

    # _evcmd_change_parallax_background
    def change_parallax_background(filename, loop_x = false, loop_y = false, sx = 0, sy = 0)
      _evcmd_change_parallax_background filename, loop_x, loop_y, sx, sy
    end

    # _evcmd_get_location_info
    def get_location_info(variable_id, info_id, is_direct = false, x = 0, y = 0)
      _evcmd_get_location_info variable_id.to_i, info_id.to_i,
                               is_direct ? 0 : 1, x.to_i, y.to_i
    end

    def get_location_terrain_tag(variable_id, *args)
      get_location_info variable_id, LOCATION_INFO_TERRAIN_TAG, *args
    end

    def get_location_event_id(variable_id, *args)
      get_location_info variable_id, LOCATION_INFO_EVENT_ID, *args
    end

    def get_location_tile_id1(variable_id, *args)
      get_location_info variable_id, LOCATION_INFO_TILE_ID_1, *args
    end

    def get_location_tile_id2(variable_id, *args)
      get_location_info variable_id, LOCATION_INFO_TILE_ID_2, *args
    end

    def get_location_tile_id3(variable_id, *args)
      get_location_info variable_id, LOCATION_INFO_TILE_ID_3, *args
    end

    def get_location_region_id(variable_id, *args)
      get_location_info variable_id, LOCATION_INFO_REGION_ID, *args
    end

    # _evcmd_process_battle
    # _evcmd_battle_branch_win
    # _evcmd_battle_branch_escape
    # _evcmd_battle_branch_lose
    def process_battle(opcode, p1, can_escape, can_lose)
      _evcmd_process_battle(opcode, p1, !!can_escape, !!can_lose)
    end

    def process_battle_id(troop_id, can_escape, can_lose)
      process_battle(0, troop_id, can_escape, can_lose)
    end

    def process_battle_var(var_id, can_escape, can_lose)
      process_battle(1, var_id, can_escape, can_lose)
    end

    def process_battle_random(can_escape, can_lose)
      process_battle(2, nil, can_escape, can_lose)
    end

    alias :goto_battle :process_battle

    # _evcmd_process_shop
    # _evcmd_shop_item
    def process_shop(goods, purchase_only=false)
      first = goods.pop
      _evcmd_process_shop(*first, purchase_only)
      goods.each { |good| _evcmd_shop_item *good }
    end

    def shop_good(item_type, item_id, overload_price=false, new_price=0)
      [item_type.to_i, item_id.to_i, overload_price ? 0 : 1, new_price]
    end

    alias :goto_shop :process_shop

    # _evcmd_process_name_input
    def process_name_input(actor_id, max_char)
      _evcmd_process_name_input(actor_id, max_char)
    end
    alias :goto_name_input :process_name_input

    # _evcmd_process_menu
    def process_menu
      _evcmd_process_menu
    end
    alias :goto_menu :process_menu

    # _evcmd_process_save
    def process_save
      _evcmd_process_save
    end
    alias :goto_save :process_save

    # _evcmd_process_gameover
    def process_gameover
      _evcmd_process_gameover
    end
    alias :goto_gameover :process_gameover

    # _evcmd_process_title
    def process_title
      _evcmd_process_title
    end
    alias :goto_title :process_title

    # _evcmd_change_actor_hp
    CHANGE_ACTOR_HP_INCREASE = 0
    CHANGE_ACTOR_HP_DECREASE = 1
    def change_actor_hp(opcode, p1, operation, operand_type, operand, can_die)
      _evcmd_change_actor_hp(opcode, p1, operation, operand_type, operand, !!can_die)
    end

    def change_actor_hp_id(actor_id, operation, operand_type, operand, can_die)
      change_actor_hp(0, actor_id, operation, operand_type, operand, can_die)
    end

    def change_actor_hp_id_i(actor_id, operation, hp, can_die)
      change_actor_hp_id(actor_id, operation, 0, hp, can_die)
    end

    def change_actor_hp_id_var(actor_id, operation, var_id, can_die)
      change_actor_hp_id(actor_id, operation, 1, var_id, can_die)
    end

    def change_actor_hp_var(var_id, operation, operand_type, operand, can_die)
      change_actor_hp(1, var_id, operation, operand_type, operand, can_die)
    end

    def change_actor_hp_var_i(var_id, operation, hp, can_die)
      change_actor_hp_var(var_id, operation, 0, hp, can_die)
    end

    def change_actor_hp_var_var(var_id, operation, var_id2, can_die)
      change_actor_hp_var(var_id, operation, 1, var_id2, can_die)
    end

    # _evcmd_change_actor_mp
    CHANGE_ACTOR_MP_INCREASE = 0
    CHANGE_ACTOR_MP_DECREASE = 1
    def change_actor_mp(opcode, p1, operation, operand_type, operand)
      _evcmd_change_actor_mp(opcode, p1, operation, operand_type, operand)
    end

    def change_actor_mp_id(actor_id, operation, operand_type, operand)
      change_actor_mp(0, actor_id, operation, operand_type, operand)
    end

    def change_actor_mp_id_i(actor_id, operation, mp)
      change_actor_mp_id(actor_id, operation, 0, mp)
    end

    def change_actor_mp_id_var(actor_id, operation, var_id)
      change_actor_mp_id(actor_id, operation, 1, var_id)
    end

    def change_actor_mp_var(var_id, operation, operand_type, operand)
      change_actor_mp(1, var_id, operation, operand_type, operand)
    end

    def change_actor_mp_var_i(var_id, operation, mp)
      change_actor_mp_var(var_id, operation, 0, mp)
    end

    def change_actor_mp_var_var(var_id, operation, var_id2)
      change_actor_mp_var(var_id, operation, 1, var_id2)
    end

    # _evcmd_change_actor_state
    CHANGE_ACTOR_STATE_ADD = 0
    CHANGE_ACTOR_STATE_REMOVE = 1
    def change_actor_state(opcode, p1, operation, state_id)
      _evcmd_change_actor_state(opcode, p1, operation, state_id)
    end

    def change_actor_state_id(actor_id, operation, state_id)
      change_actor_state(0, actor_id, operation, state_id)
    end

    def change_actor_state_var(var_id, operation, state_id)
      change_actor_state(1, var_id, operation, state_id)
    end

    # _evcmd_actor_recover_all

    # _evcmd_change_actor_exp
    CHANGE_ACTOR_EXP_INCREASE = 0
    CHANGE_ACTOR_EXP_DECREASE = 1
    def change_actor_exp(opcode, p1, operation, operand_type, operand, display_level_up)
      _evcmd_change_actor_exp(opcode, p1, operation, operand_type, operand, !!display_level_up)
    end

    def change_actor_exp_id(actor_id, operation, operand_type, operand, display_level_up)
      change_actor_exp(0, actor_id, operation, operand_type, operand, display_level_up)
    end

    def change_actor_exp_id_i(actor_id, operation, exp, display_level_up)
      change_actor_exp_id(actor_id, operation, 0, exp, display_level_up)
    end

    def change_actor_exp_id_var(actor_id, operation, var_id, display_level_up)
      change_actor_exp_id(actor_id, operation, 1, var_id, display_level_up)
    end

    def change_actor_exp_var(var_id, operation, operand_type, operand, display_level_up)
      change_actor_exp(1, var_id, operation, operand_type, operand, display_level_up)
    end

    def change_actor_exp_var_i(var_id, operation, exp, display_level_up)
      change_actor_exp_var(var_id, operation, 0, exp, display_level_up)
    end

    def change_actor_exp_var_var(var_id, operation, var_id2, display_level_up)
      change_actor_exp_var(var_id, operation, 1, var_id2, display_level_up)
    end

    # _evcmd_change_actor_level
    CHANGE_ACTOR_LEVEL_INCREASE = 0
    CHANGE_ACTOR_LEVEL_DECREASE = 1
    def change_actor_level(opcode, p1, operation, operand_type, operand, display_level_up)
      _evcmd_change_actor_level(opcode, p1, operation, operand_type, operand, !!display_level_up)
    end

    def change_actor_level_id(actor_id, operation, operand_type, operand, display_level_up)
      change_actor_level(0, actor_id, operation, operand_type, operand, display_level_up)
    end

    def change_actor_level_id_i(actor_id, operation, level, display_level_up)
      change_actor_level_id(actor_id, operation, 0, level, display_level_up)
    end

    def change_actor_level_id_var(actor_id, operation, var_id, display_level_up)
      change_actor_level_id(actor_id, operation, 1, var_id, display_level_up)
    end

    def change_actor_level_var(var_id, operation, operand_type, operand, display_level_up)
      change_actor_level(1, var_id, operation, operand_type, operand, display_level_up)
    end

    def change_actor_level_var_i(var_id, operation, level, display_level_up)
      change_actor_level_var(var_id, operation, 0, level, display_level_up)
    end

    def change_actor_level_var_var(var_id, operation, var_id2, display_level_up)
      change_actor_level_var(var_id, operation, 1, var_id2, display_level_up)
    end

    # _evcmd_change_actor_parameters
    CHANGE_ACTOR_PARAMETER_INCREASE = 0
    CHANGE_ACTOR_PARAMETER_DECREASE = 1
    def change_actor_parameter(opcode, p1, param_id, operation, operand_type, operand)
      _evcmd_change_actor_parameter(opcode, p1, param_id, operation, operand_type, operand)
    end

    def change_actor_parameter_id(actor_id, param_id, operation, operand_type, operand)
      change_actor_parameter(0, actor_id, param_id, operation, operand_type, operand)
    end

    def change_actor_parameter_id_i(actor_id, param_id, operation, level)
      change_actor_parameter_id(actor_id, param_id, operation, 0, level)
    end

    def change_actor_parameter_id_var(actor_id, param_id, operation, var_id)
      change_actor_parameter_id(actor_id, param_id, operation, 1, var_id)
    end

    def change_actor_parameter_var(var_id, param_id, operation, operand_type, operand)
      change_actor_parameter(1, var_id, param_id, operation, operand_type, operand)
    end

    def change_actor_parameter_var_i(var_id, param_id, operation, level)
      change_actor_parameter_var(var_id, param_id, operation, 0, level)
    end

    def change_actor_parameter_var_var(var_id, param_id, operation, var_id2)
      change_actor_parameter_var(var_id, param_id, operation, 1, var_id2)
    end

    # _evcmd_change_actor_skill
    CHANGE_ACTOR_SKILL_ADD = 0
    CHANGE_ACTOR_SKILL_REMOVE = 1
    def change_actor_skill(opcode, p1, operation, skill_id)
      _evcmd_change_actor_skill(opcode, p1, operation, skill_id)
    end

    def change_actor_skill_id(actor_id, operation, skill_id)
      change_actor_skill(0, actor_id, operation, skill_id)
    end

    def change_actor_skill_var(var_id, operation, skill_id)
      change_actor_skill(1, var_id, operation, skill_id)
    end

    # _evcmd_change_actor_equip
    def change_actor_equip(actor_id, slot_id, item_id)
      _evcmd_change_actor_equip(actor_id, slot_id, item_id)
    end

    # _evcmd_change_actor_name
    def change_actor_name(actor_id, name)
      _evcmd_change_actor_name(actor_id, name)
    end

    # _evcmd_change_actor_class
    def change_actor_class(actor_id, klass_id)
      _evcmd_change_actor_class(actor_id, klass_id)
    end

    # _evcmd_change_actor_graphic
    def change_actor_graphic(actor_id, character_name, character_index, face_name, face_index)
      _evcmd_change_actor_graphic(actor_id, character_name, character_index, face_name, face_index)
    end

    # _evcmd_change_vehicle_graphic
    def change_vehicle_graphic(vehicle_id, character_name, character_index)
      _evcmd_change_vehicle_graphic vehicle_id, character_name, character_index
    end

    # _evcmd_change_actor_nickname
    def change_actor_nickname(actor_id, nickname)
      _evcmd_change_actor_nickname(actor_id, nickname)
    end

    # _evcmd_change_enemy_hp
    def change_enemy_hp(enemy_index, operation, operand_type, operand, can_die)
      _evcmd_change_enemy_hp(enemy_index, operation, operand_type, operand, !!can_die)
    end

    # _evcmd_change_enemy_mp
    def change_enemy_mp(enemy_index, operation, operand_type, operand)
      _evcmd_change_enemy_hp(enemy_index, operation, operand_type, operand)
    end

    # _evcmd_change_enemy_state
    CHANGE_ENEMY_STATE_ADD = 0
    CHANGE_ENEMY_STATE_REMOVE = 1
    def change_enemy_state(enemy_index, operation, state_id)
      _evcmd_change_enemy_state(enemy_index, operation, state_id)
    end

    def change_enemy_state_add(enemy_index, state_id)
      change_enemy_state(enemy_index, CHANGE_ENEMY_STATE_ADD, state_id)
    end

    def change_enemy_state_remove(enemy_index, state_id)
      change_enemy_state(enemy_index, CHANGE_ENEMY_STATE_REMOVE, state_id)
    end

    # _evcmd_enemy_recover_all
    def enemy_recover_all(enemy_index)
      _evcmd_enemy_recover_all(enemy_index)
    end

    # _evcmd_enemy_appear
    def enemy_appear(enemy_index)
      _evcmd_enemy_appear(enemy_index)
    end

    # _evcmd_enemy_transform
    def enemy_transform(enemy_index, new_enemy_id)
      _evcmd_enemy_transform(enemy_index, new_enemy_id)
    end

    # _evcmd_show_battle_animation
    def show_battle_animation(enemy_index, animation_id)
      _evcmd_show_battle_animation(enemy_index, animation_id)
    end

    # _evcmd_battle_force_action
    def battle_force_action(battler_type, p1, skill_id, target_index)
      _evcmd_battle_force_action(battler_type, p1, skill_id, target_index)
    end

    def battle_force_action_enemy(enemy_index, skill_id, target_index)
      battle_force_action(0, actor_id, skill_id, target_index)
    end

    def battle_force_action_actor(actor_id, skill_id, target_index)
      battle_force_action(1, actor_id, skill_id, target_index)
    end

    # _evcmd_battle_abort
    def battle_abort
      _evcmd_battle_abort
    end
    alias :abort_battle :battle_abort

    # _evcmd_script
    # _evcmd_script_text
    def script(str)
      lines = str.each_line.to_a
      first = lines.pop
      _evcmd_script(first)
      lines.each { |line| _evcmd_script_text line }
    end

    # _evcmd_if
    alias :eif :conditional_branch
    # _evcmd_transfer_player
    alias :transfer_player :set_player_position
    # _evcmd_eval
    alias :eeval :script
  end
end
