require 'rgss_tk/rgss3/rpg'
require 'json'

module RgssTk
  def self.rpg_to_h(obj)
    case obj
    when RPG::AudioFile, Tone, Color, Table
      obj.to_h
    else
      obj
    end
  end
end

class Color
  def to_h
    {
      red: @red,
      green: @green,
      blue: @blue,
      alpha: @alpha
    }
  end

  def to_json(depth = 0)
    to_h.to_json(depth)
  end
end

class Tone
  def to_h
    {
      red: @red,
      green: @green,
      blue: @blue,
      gray: @gray
    }
  end

  def to_json(depth = 0)
    to_h.to_json(depth)
  end
end

class Table
  def to_h
    {
      dimensions: @dimensions,
      xsize: @xsize,
      ysize: @ysize,
      zsize: @zsize,
      size: @size,
      data: @data,
    }
  end

  def to_json(depth = 0)
    to_h.to_json(depth)
  end
end

class RPG::Actor
  def to_h
    super.merge({
      nickname: @nickname,
      class_id: @class_id,
      initial_level: @initial_level,
      max_level: @max_level,
      character_name: @character_name,
      character_index: @character_index,
      face_name: @face_name,
      face_index: @face_index,
      equips: @equips
    })
  end

  def to_json(depth = 0)
    to_h.to_json(depth)
  end
end

class RPG::Animation
  def to_h
    {
      id: @id,
      name: @name,
      animation1_name: @animation1_name,
      animation1_hue: @animation1_hue,
      animation2_name: @animation2_name,
      animation2_hue: @animation2_hue,
      position: @position,
      frame_max: @frame_max,
      frames: @frames.map(&:to_h),
      timings: @timings.map(&:to_h),
    }
  end

  def to_json(depth = 0)
    to_h.to_json(depth)
  end
end

class RPG::Animation::Frame
  def to_h
    {
      cell_max: @cell_max,
      cell_data: @cell_data.to_h,
    }
  end

  def to_json(depth = 0)
    to_h.to_json(depth)
  end
end

class RPG::Animation::Timing
  def to_h
    {
      frame: @frame,
      se: @se.to_h,
      flash_scope: @flash_scope,
      flash_color: @flash_color.to_h,
      flash_duration: @flash_duration,
    }
  end

  def to_json(depth = 0)
    to_h.to_json(depth)
  end
end

class RPG::Armor
  def to_h
    super.merge({
      atype_id: @atype_id,
      etype_id: @etype_id
    })
  end

  def to_json(depth = 0)
    to_h.to_json(depth)
  end
end

class RPG::AudioFile
  def to_h
    {
      name: @name,
      volume: @volume,
      pitch: @pitch
    }
  end

  def to_json(depth = 0)
    to_h.to_json(depth)
  end
end

class RPG::BaseItem
  def to_h
    {
      id: @id,
      name: @name,
      icon_index: @icon_index,
      description: @description,
      features: @features.map(&:to_h),
      note: @note
    }
  end

  def to_json(depth = 0)
    to_h.to_json(depth)
  end
end

class RPG::BaseItem::Feature
  def to_h
    {
      code: @code,
      data_id: @data_id,
      value: @value
    }
  end

  def to_json(depth = 0)
    to_h.to_json(depth)
  end
end

class RPG::Class
  def to_h
    super.merge({
      exp_params: @exp_params,
      params: @params.to_h,
      learnings: @learnings.map(&:to_h)
    })
  end

  def to_json(depth = 0)
    to_h.to_json(depth)
  end
end

class RPG::Class::Learning
  def to_h
    {
      level: @level,
      skill_id: @skill_id,
      note: @note
    }
  end

  def to_json(depth = 0)
    to_h.to_json(depth)
  end
end

class RPG::CommonEvent
  def to_h
    {
      id: @id,
      name: @name,
      trigger: @trigger,
      switch_id: @switch_id,
      list: @list.map(&:to_h)
    }
  end

  def to_json(depth = 0)
    to_h.to_json(depth)
  end
end

class RPG::Enemy
  def to_h
    super.merge({
      battler_name: @battler_name,
      battler_hue: @battler_hue,
      params: @params,
      exp: @exp,
      gold: @gold,
      drop_items: @drop_items.map(&:to_h),
      actions: @actions.map(&:to_h)
    })
  end

  def to_json(depth = 0)
    to_h.to_json(depth)
  end
end

class RPG::Enemy::Action
  def to_h
    {
      skill_id: @skill_id,
      condition_type: @condition_type,
      condition_param1: @condition_param1,
      condition_param2: @condition_param2,
      rating: @rating
    }
  end

  def to_json(depth = 0)
    to_h.to_json(depth)
  end
end

class RPG::Enemy::DropItem
  def to_h
    {
      kind: @kind,
      data_id: @data_id,
      denominator: @denominator
    }
  end

  def to_json(depth = 0)
    to_h.to_json(depth)
  end
end

class RPG::EquipItem
  def to_h
    super.merge({
      price: @price,
      etype_id: @etype_id,
      params: @params
    })
  end

  def to_json(depth = 0)
    to_h.to_json(depth)
  end
end

class RPG::Event
  def to_h
    {
      id: @id,
      name: @name,
      x: @x,
      y: @y,
      pages: @pages.map(&:to_h)
    }
  end

  def to_json(depth = 0)
    to_h.to_json(depth)
  end
end

class RPG::Event::Page
  def to_h
    {
      condition: @condition.to_h,
      graphic: @graphic.to_h,
      move_type: @move_type,
      move_speed: @move_speed,
      move_frequency: @move_frequency,
      move_route: @move_route.to_h,
      walk_anime: @walk_anime,
      step_anime: @step_anime,
      direction_fix: @direction_fix,
      through: @through,
      priority_type: @priority_type,
      trigger: @trigger,
      list: @list.map(&:to_h)
    }
  end

  def to_json(depth = 0)
    to_h.to_json(depth)
  end
end

class RPG::Event::Page::Condition
  def to_h
    {
      switch1_valid: @switch1_valid,
      switch2_valid: @switch2_valid,
      variable_valid: @variable_valid,
      self_switch_valid: @self_switch_valid,
      item_valid: @item_valid,
      action_valid: @action_valid,
      switch1_id: @switch1_id,
      switch2_id: @switch2_id,
      variable_id: @variable_id,
      variable_value: @variable_value,
      self_switch_ch: @self_switch_ch,
      item_id: @item_id,
      actor_id: @actor_id
    }
  end

  def to_json(depth = 0)
    to_h.to_json(depth)
  end
end

class RPG::Event::Page::Graphic
  def to_h
    {
      tile_id: @tile_id,
      character_name: @character_name,
      character_index: @character_index,
      self_switch_valid: @self_switch_valid,
      direction: @direction,
      pattern: @pattern
    }
  end

  def to_json(depth = 0)
    to_h.to_json(depth)
  end
end

class RPG::EventCommand
  def to_h
    parameters = @parameters.map do |obj|
      RgssTk.rpg_to_h obj
    end
    {
      code: @code,
      indent: @indent,
      parameters: parameters
    }
  end

  def to_json(depth = 0)
    to_h.to_json(depth)
  end
end

class RPG::Item
  def to_h
    super.merge({
      itype_id: @itype_id,
      price: @price,
      consumable: @consumable
    })
  end

  def to_json(depth = 0)
    to_h.to_json(depth)
  end
end

class RPG::Map
  def to_h
    {
      display_name: @display_name,
      tileset_id: @tileset_id,
      width: @width,
      height: @height,
      scroll_type: @scroll_type,
      specify_battleback: @specify_battleback,
      battleback_floor_name: @battleback_floor_name,
      battleback_wall_name: @battleback_wall_name,
      autoplay_bgm: @autoplay_bgm,
      bgm: @bgm.to_h,
      autoplay_bgs: @autoplay_bgs,
      bgs: @bgs.to_h,
      disable_dashing: @disable_dashing,
      encounter_list: @encounter_list.map(&:to_h),
      encounter_step: @encounter_step,
      parallax_name: @parallax_name,
      parallax_loop_x: @parallax_loop_x,
      parallax_loop_y: @parallax_loop_y,
      parallax_sx: @parallax_sx,
      parallax_sy: @parallax_sy,
      parallax_show: @parallax_show,
      note: @note,
      data: @data.to_h,
      events: Hash[@events.map{|k,v|[k,v.to_h]}],
    }
  end

  def to_json(depth = 0)
    to_h.to_json(depth)
  end
end

class RPG::Map::Encounter
  def to_h
    {
      troop_id: @troop_id,
      weight: @weight,
      region_set: @region_set
    }
  end

  def to_json(depth = 0)
    to_h.to_json(depth)
  end
end

class RPG::MapInfo
  def to_h
    {
      name: @name,
      parent_id: @parent_id,
      order: @order,
      expanded: @expanded,
      scroll_x: @scroll_x,
      scroll_y: @scroll_y
    }
  end

  def to_json(depth = 0)
    to_h.to_json(depth)
  end
end

class RPG::MoveCommand
  def to_h
    parameters = @parameters.map do |obj|
      RgssTk.rpg_to_h obj
    end
    {
      code: @code,
      parameters: parameters
    }
  end

  def to_json(depth = 0)
    to_h.to_json(depth)
  end
end

class RPG::MoveRoute
  def to_h
    {
      repeat: @repeat,
      skippable: @skippable,
      wait: @wait,
      list: @list.map(&:to_h)
    }
  end

  def to_json(depth = 0)
    to_h.to_json(depth)
  end
end

class RPG::Skill
  def to_h
    super.merge({
      stype_id: @stype_id,
      mp_cost: @mp_cost,
      tp_cost: @tp_cost,
      message1: @message1,
      message2: @message2,
      required_wtype_id1: @required_wtype_id1,
      required_wtype_id2: @required_wtype_id2
    })
  end

  def to_json(depth = 0)
    to_h.to_json(depth)
  end
end

class RPG::State
  def to_h
    super.merge({
      restriction: @restriction,
      priority: @priority,
      remove_at_battle_end: @remove_at_battle_end,
      remove_by_restriction: @remove_by_restriction,
      auto_removal_timing: @auto_removal_timing,
      min_turns: @min_turns,
      max_turns: @max_turns,
      remove_by_damage: @remove_by_damage,
      chance_by_damage: @chance_by_damage,
      remove_by_walking: @remove_by_walking,
      steps_to_remove: @steps_to_remove,
      message1: @message1,
      message2: @message2,
      message3: @message3,
      message4: @message4
    })
  end

  def to_json(depth = 0)
    to_h.to_json(depth)
  end
end

class RPG::System
  def to_h
    {
      game_title: @game_title,
      version_id: @version_id,
      japanese: @japanese,
      party_members: @party_members,
      currency_unit: @currency_unit,
      elements: @elements,
      skill_types: @skill_types,
      weapon_types: @weapon_types,
      armor_types: @armor_types,
      switches: @switches,
      variables: @variables,
      boat: @boat.to_h,
      ship: @ship.to_h,
      airship: @airship.to_h,
      title1_name: @title1_name,
      title2_name: @title2_name,
      opt_draw_title: @opt_draw_title,
      opt_use_midi: @opt_use_midi,
      opt_transparent: @opt_transparent,
      opt_followers: @opt_followers,
      opt_slip_death: @opt_slip_death,
      opt_floor_death: @opt_floor_death,
      opt_display_tp: @opt_display_tp,
      opt_extra_exp: @opt_extra_exp,
      window_tone: @window_tone.to_h,
      title_bgm: @title_bgm.to_h,
      battle_bgm: @battle_bgm.to_h,
      battle_end_me: @battle_end_me.to_h,
      gameover_me: @gameover_me.to_h,
      sounds: @sounds.map(&:to_h),
      test_battlers: @test_battlers.map(&:to_h),
      test_troop_id: @test_troop_id,
      start_map_id: @start_map_id,
      start_x: @start_x,
      start_y: @start_y,
      terms: @terms.to_h,
      battleback1_name: @battleback1_name,
      battleback2_name: @battleback2_name,
      battler_name: @battler_name,
      battler_hue: @battler_hue,
      edit_map_id: @edit_map_id
    }
  end

  def to_json(depth = 0)
    to_h.to_json(depth)
  end
end

class RPG::System::Terms
  def to_h
    {
      basic: @basic,
      params: @params,
      etypes: @etypes,
      commands: @commands
    }
  end

  def to_json(depth = 0)
    to_h.to_json(depth)
  end
end

class RPG::System::TestBattler
  def to_h
    {
      actor_id: @actor_id,
      level: @level,
      equips: @equips
    }
  end

  def to_json(depth = 0)
    to_h.to_json(depth)
  end
end

class RPG::System::Vehicle
  def to_h
    {
      character_name: @character_name,
      character_index: @character_index,
      bgm: @bgm.to_h,
      start_map_id: @start_map_id,
      start_x: @start_x,
      start_y: @start_y
    }
  end

  def to_json(depth = 0)
    to_h.to_json(depth)
  end
end

class RPG::Tileset
  def to_h
    {
      id: @id,
      mode: @mode,
      name: @name,
      tileset_names: @tileset_names,
      flags: @flags.to_h,
      note: @note
    }
  end

  def to_json(depth = 0)
    to_h.to_json(depth)
  end
end

class RPG::Troop
  def to_h
    {
      id: @id,
      name: @name,
      members: @members.map(&:to_h),
      pages: @pages.map(&:to_h)
    }
  end

  def to_json(depth = 0)
    to_h.to_json(depth)
  end
end

class RPG::Troop::Member
  def to_h
    {
      enemy_id: @enemy_id,
      x: @x,
      y: @y,
      hidden: @hidden,
    }
  end

  def to_json(depth = 0)
    to_h.to_json(depth)
  end
end

class RPG::Troop::Page
  def to_h
    {
      condition: @condition.to_h,
      span: @span,
      list: @list.map(&:to_h)
    }
  end

  def to_json(depth = 0)
    to_h.to_json(depth)
  end
end

class RPG::Troop::Page::Condition
  def to_h
    {
      turn_ending: @turn_ending,
      turn_valid: @turn_valid,
      enemy_valid: @enemy_valid,
      actor_valid: @actor_valid,
      switch_valid: @switch_valid,
      turn_a: @turn_a,
      turn_b: @turn_b,
      enemy_index: @enemy_index,
      enemy_hp: @enemy_hp,
      actor_id: @actor_id,
      actor_hp: @actor_hp,
      switch_id: @switch_id,
    }
  end

  def to_json(depth = 0)
    to_h.to_json(depth)
  end
end

class RPG::UsableItem
  def to_h
    super.merge({
      scope: @scope,
      occasion: @occasion,
      speed: @speed,
      success_rate: @success_rate,
      repeats: @repeats,
      tp_gain: @tp_gain,
      hit_type: @hit_type,
      animation_id: @animation_id,
      damage: @damage.to_h,
      effects: @effects.map(&:to_h)
    })
  end

  def to_json(depth = 0)
    to_h.to_json(depth)
  end
end

class RPG::UsableItem::Damage
  def to_h
    {
      type: @type,
      element_id: @element_id,
      formula: @formula,
      variance: @variance,
      critical: @critical
    }
  end

  def to_json(depth = 0)
    to_h.to_json(depth)
  end
end

class RPG::UsableItem::Effect
  def to_h
    {
      code: @code,
      data_id: @data_id,
      value1: @value1,
      value2: @value2
    }
  end

  def to_json(depth = 0)
    to_h.to_json(depth)
  end
end

class RPG::Weapon
  def to_h
    super.merge({
      wtype_id: @wtype_id,
      animation_id: @animation_id
    })
  end

  def to_json(depth = 0)
    to_h.to_json(depth)
  end
end
