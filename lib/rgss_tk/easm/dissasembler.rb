require 'rgss_tk/event_command_codes'

module RgssTk
  module EASM
    class Dissasembler
      include EventCommandCodes

      class InvalidCode < RuntimeError
        def initialize(code, indent, params)
          super "Invalid EventCommand code #{code} (indent: #{indent}, params: #{params})"
        end
      end

      module ObjectDumps
        def dump_move_command(obj)
          "#{obj.class.name}.new(#{obj.code}, #{dump(obj.parameters)})"
        end

        def dump(obj, wrap = true)
          case obj
          when Array
            data = obj.map do |o|
              dump(o)
            end.join(', ')
            wrap ? "[#{data}]" : data
          when RPG::AudioFile
            "#{obj.class.name}.new(#{obj.name.dump}, #{obj.volume}, #{obj.pitch})"
          when RPG::MoveCommand
            dump_move_command(obj)
          when Color
            "#{obj.class.name}.new(#{obj.red}, #{obj.green}, #{obj.blue}, #{obj.alpha})"
          when Tone
            "#{obj.class.name}.new(#{obj.red}, #{obj.green}, #{obj.blue}, #{obj.gray})"
          when Rect
            "#{obj.class.name}.new(#{obj.x}, #{obj.y}, #{obj.width}, #{obj.height})"
          when String
            obj.dump
          when Integer, Float
            obj.to_s
          when true
            'true'
          when false
            'false'
          when nil
            'nil'
          else
            raise "Cannot dump #{obj} (of class #{obj.class})"
          end
        end

        extend self
      end

      class DsmCommand
        include EventCommandCodes
        include ObjectDumps

        class Variable
          attr_accessor :name
          attr_accessor :index

          def initialize(name, index)
            @name = name
            @index = index
          end
        end

        attr_accessor :code
        attr_accessor :name
        attr_accessor :indent
        attr_accessor :params

        def initialize(code, name, indent, params)
          @code = code
          @name = name
          @indent = indent
          @params = params
          @variables = []
        end

        def var(name, index)
          @variables << Variable.new(name, index)
          self
        end

        def params_str
          dump(@params, false)
        end

        def indent_str(conf)
          "#{conf.spacer * @indent}"
        end

        def command_str(conf)
          "#{indent_str(conf)}#{@name}"
        end

        def to_easm(conf)
          case @code
          when CODE_SET_MOVE_ROUTE
            var = 0
            result = "#{indent_str(conf)}begin\n"
            vars = @params.map do |o|
              if o.is_a?(RPG::MoveRoute)
                varname = "var#{var}"
                var += 1
                result << "#{conf.spacer}#{indent_str(conf)}#{varname} = RPG::MoveRoute.new\n"
                result << "#{conf.spacer}#{indent_str(conf)}#{varname}.repeat = #{dump(o.repeat)}\n"
                result << "#{conf.spacer}#{indent_str(conf)}#{varname}.skippable = #{dump(o.skippable)}\n"
                result << "#{conf.spacer}#{indent_str(conf)}#{varname}.wait = #{dump(o.wait)}\n"
                result << "#{conf.spacer}#{indent_str(conf)}#{varname}.list = #{dump(o.list)}\n"
                varname
              else
                dump(o)
              end
            end
            vars_str = vars.join(', ')
            result << "#{conf.spacer}#{command_str(conf)} #{vars_str}\n"
            result << "#{indent_str(conf)}end"
          else
            "#{command_str(conf)} #{params_str}"
          end
        end
      end

      def dissasemble_command(command)
        code = command.code
        indent = command.indent
        params = command.parameters

        cmd = DsmCommand.new(code, nil, indent, params)

        case code
        when CODE_NULL
          cmd.name = 'nocmd'
        when CODE_SHOW_TEXT
          cmd.name = 'show_text'
          cmd.var 'face_name',  0
          cmd.var 'face_index', 1
          cmd.var 'backgound',  2
          cmd.var 'position',   3
          cmd
        when CODE_TEXT
          cmd.name = 'text'
        when CODE_SHOW_CHOICE
          cmd.name = 'show_choice'
        when CODE_CHOICE_BRANCH
          cmd.name = 'choice_branch'
        when CODE_CHOICE_CANCEL
          cmd.name = 'choice_cancel'
        when CODE_BRANCH_END
          cmd.name = 'branch_end'
        when CODE_SHOW_NUM_INPUT
          cmd.name = 'show_num_input'
        when CODE_SHOW_ITEM_CHOICE
          cmd.name = 'show_item_choice'
        when CODE_SHOW_TEXT_SCROLLING
          cmd.name = 'show_text_scrolling'
        when CODE_TEXT_SCROLLING
          cmd.name = 'text_scrolling'
        when CODE_COMMENT
          cmd.name = 'comment'
        when CODE_COMMENT_TEXT
          cmd.name = 'comment_text'
        when CODE_CONDITIONAL_BRANCH
          cmd.name = 'conditional_branch'
        when CODE_CONDITIONAL_BRANCH_ELSE
          cmd.name = 'conditional_branch_else'
        when CODE_CONDITIONAL_BRANCH_END
          cmd.name = 'conditional_branch_end'
        when CODE_LOOP
          cmd.name = 'eloop'
        when CODE_REPEAT
          cmd.name = 'erepeat'
        when CODE_BREAK
          cmd.name = 'ebreak'
        when CODE_TERMINATE
          cmd.name = 'terminate'
        when CODE_CALL_COMMON_EVENT
          cmd.name = 'call_common_event'
        when CODE_LABEL
          cmd.name = 'label'
        when CODE_JUMP_TO_LABEL
          cmd.name = 'jump_to_label'
        when CODE_CONTROL_SWITCH
          cmd.name = 'control_switch'
        when CODE_CONTROL_VARIABLE
          cmd.name = 'control_variable'
        when CODE_CONTROL_SELF_SWITCH
          cmd.name = 'control_self_switch'
        when CODE_CONTROL_TIMER
          cmd.name = 'control_timer'
        when CODE_CHANGE_GOLD
          cmd.name = 'change_gold'
        when CODE_CHANGE_ITEM
          cmd.name = 'change_item'
        when CODE_CHANGE_WEAPON
          cmd.name = 'change_weapon'
        when CODE_CHANGE_ARMOR
          cmd.name = 'change_armor'
        when CODE_CHANGE_PARTY_MEMBER
          cmd.name = 'change_party_member'
        when CODE_CHANGE_BATTLE_BGM
          cmd.name = 'change_battle_bgm'
        when CODE_CHANGE_BATTLE_END_ME
          cmd.name = 'change_battle_end_me'
        when CODE_CHANGE_SAVE_ACCESS
          cmd.name = 'change_save_access'
        when CODE_CHANGE_MENU_ACCESS
          cmd.name = 'change_menu_access'
        when CODE_CHANGE_ENCOUNTER
          cmd.name = 'change_encounter'
        when CODE_CHANGE_FORMATION_ACCESS
          cmd.name = 'change_formation_access'
        when CODE_CHANGE_WINDOW_TONE
          cmd.name = 'change_window_tone'
        when CODE_SET_PLAYER_POSITION
          cmd.name = 'set_player_position'
        when CODE_SET_VEHICLE_POSITION
          cmd.name = 'set_vehicle_position'
        when CODE_SET_EVENT_POSITION
          cmd.name = 'set_event_position'
        when CODE_SCROLL_MAP
          cmd.name = 'scroll_map'
        when CODE_SET_MOVE_ROUTE
          cmd.name = 'set_move_route'
        when CODE_MOVE_COMMAND
          cmd.name = 'move_command'
          # skip move command lines
          return nil
        when CODE_GET_ON_OFF_VEHICLE
          cmd.name = 'get_on_off_vehicle'
        when CODE_CHANGE_TRANSPERENCY
          cmd.name = 'change_transperency'
        when CODE_SHOW_ANIMATION
          cmd.name = 'show_animation'
        when CODE_SHOW_BALLOON
          cmd.name = 'show_balloon'
        when CODE_ERASE_EVENT
          cmd.name = 'erase_event'
        when CODE_SET_FOLLOWERS_VISIBLITY
          cmd.name = 'set_followers_visiblity'
        when CODE_GATHER_FOLLOWERS
          cmd.name = 'gather_followers'
        when CODE_SCREEN_FADEOUT
          cmd.name = 'screen_fadeout'
        when CODE_SCREEN_FADEIN
          cmd.name = 'screen_fadein'
        when CODE_SCREEN_TINT
          cmd.name = 'screen_tint'
        when CODE_SCREEN_FLASH
          cmd.name = 'screen_flash'
        when CODE_SCREEN_SHAKE
          cmd.name = 'screen_shake'
        when CODE_WAIT
          cmd.name = 'wait'
        when CODE_SHOW_PICTURE
          cmd.name = 'show_picture'
        when CODE_MOVE_PICTURE
          cmd.name = 'move_picture'
        when CODE_ROTATE_PICTURE
          cmd.name = 'rotate_picture'
        when CODE_TINT_PICTURE
          cmd.name = 'tint_picture'
        when CODE_ERASE_PICTURE
          cmd.name = 'erase_picture'
        when CODE_SET_WEATHER
          cmd.name = 'set_weather'
        when CODE_BGM_PLAY
          cmd.name = 'bgm_play'
        when CODE_BGM_FADEOUT
          cmd.name = 'bgm_fadeout'
        when CODE_BGM_SAVE
          cmd.name = 'bgm_save'
        when CODE_BGM_RESUME
          cmd.name = 'bgm_resume'
        when CODE_BGS_PLAY
          cmd.name = 'bgs_play'
        when CODE_BGS_FADEOUT
          cmd.name = 'bgs_fadeout'
        when CODE_ME_PLAY
          cmd.name = 'me_play'
        when CODE_SE_PLAY
          cmd.name = 'se_play'
        when CODE_SE_STOP
          cmd.name = 'se_stop'
        when CODE_MOVIE_PLAY
          cmd.name = 'movie_play'
        when CODE_SET_MAP_NAME_DISPLAY
          cmd.name = 'set_map_name_display'
        when CODE_CHANGE_TILESET
          cmd.name = 'change_tileset'
        when CODE_CHANGE_BATTLE_BACKGROUND
          cmd.name = 'change_battle_background'
        when CODE_CHANGE_PARALLAX_BACKGROUND
          cmd.name = 'change_parallax_background'
        when CODE_GET_LOCATION_INFO
          cmd.name = 'get_location_info'
        when CODE_PROCESS_BATTLE
          cmd.name = 'process_battle'
        when CODE_BATTLE_BRANCH_WIN
          cmd.name = 'battle_branch_win'
        when CODE_BATTLE_BRANCH_ESCAPE
          cmd.name = 'battle_branch_escape'
        when CODE_BATTLE_BRANCH_LOSE
          cmd.name = 'battle_branch_lose'
        when CODE_PROCESS_SHOP
          cmd.name = 'process_shop'
        when CODE_SHOP_ITEM
          cmd.name = 'shop_item'
        when CODE_PROCESS_NAME_INPUT
          cmd.name = 'process_name_input'
        when CODE_PROCESS_MENU
          cmd.name = 'process_menu'
        when CODE_PROCESS_SAVE
          cmd.name = 'process_save'
        when CODE_PROCESS_GAMEOVER
          cmd.name = 'process_gameover'
        when CODE_PROCESS_TITLE
          cmd.name = 'process_title'
        when CODE_CHANGE_ACTOR_HP
          cmd.name = 'change_actor_hp'
        when CODE_CHANGE_ACTOR_MP
          cmd.name = 'change_actor_mp'
        when CODE_CHANGE_ACTOR_STATE
          cmd.name = 'change_actor_state'
        when CODE_ACTOR_RECOVER_ALL
          cmd.name = 'actor_recover_all'
        when CODE_CHANGE_ACTOR_EXP
          cmd.name = 'change_actor_exp'
        when CODE_CHANGE_ACTOR_LEVEL
          cmd.name = 'change_actor_level'
        when CODE_CHANGE_ACTOR_PARAMETERS
          cmd.name = 'change_actor_parameters'
        when CODE_CHANGE_ACTOR_SKILL
          cmd.name = 'change_actor_skill'
        when CODE_CHANGE_ACTOR_EQUIP
          cmd.name = 'change_actor_equip'
        when CODE_CHANGE_ACTOR_NAME
          cmd.name = 'change_actor_name'
        when CODE_CHANGE_ACTOR_CLASS
          cmd.name = 'change_actor_class'
        when CODE_CHANGE_ACTOR_GRAPHIC
          cmd.name = 'change_actor_graphic'
        when CODE_CHANGE_VEHICLE_GRAPHIC
          cmd.name = 'change_vehicle_graphic'
        when CODE_CHANGE_ACTOR_NICKNAME
          cmd.name = 'change_actor_nickname'
        when CODE_CHANGE_ENEMY_HP
          cmd.name = 'change_enemy_hp'
        when CODE_CHANGE_ENEMY_MP
          cmd.name = 'change_enemy_mp'
        when CODE_CHANGE_ENEMY_STATE
          cmd.name = 'change_enemy_state'
        when CODE_ENEMY_RECOVER_ALL
          cmd.name = 'enemy_recover_all'
        when CODE_ENEMY_APPEAR
          cmd.name = 'enemy_appear'
        when CODE_ENEMY_TRANSFORM
          cmd.name = 'enemy_transform'
        when CODE_SHOW_BATTLE_ANIMATION
          cmd.name = 'show_battle_animation'
        when CODE_BATTLE_FORCE_ACTION
          cmd.name = 'battle_force_action'
        when CODE_BATTLE_ABORT
          cmd.name = 'battle_abort'
        when CODE_SCRIPT
          cmd.name = 'script'
        when CODE_SCRIPT_TEXT
          cmd.name = 'script_text'
        else
          raise InvalidCode.new(code, indent, params)
        end

        cmd
      end

      def dissasemble(list)
        list.map do |cmd|
          dissasemble_command(cmd)
        end.compact
      end

      def self.dissasemble(list)
        new.dissasemble(list)
      end
    end
  end
end
