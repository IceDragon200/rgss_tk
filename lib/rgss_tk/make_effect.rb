require 'rgss_tk/rgss3/rpg/usable_item'
require 'rgss_tk/rgss3/rpg/usable_item/effect'

module RgssTk
  module MakeEffect
    EFFECT_RECOVER_HP     = 11
    EFFECT_RECOVER_MP     = 12
    EFFECT_GAIN_TP        = 13
    EFFECT_ADD_STATE      = 21
    EFFECT_REMOVE_STATE   = 22
    EFFECT_ADD_BUFF       = 31
    EFFECT_ADD_DEBUFF     = 32
    EFFECT_REMOVE_BUFF    = 33
    EFFECT_REMOVE_DEBUFF  = 34
    EFFECT_SPECIAL        = 41
    EFFECT_GROW           = 42
    EFFECT_LEARN_SKILL    = 43
    EFFECT_COMMON_EVENT   = 44
    # //
    SPECIAL_EFFECT_ESCAPE = 0

    def effect(code, data_id, value1, value2)
      RPG::UsableItem::Effect.new(code, data_id, value1.to_f, value2.to_f)
    end

    def recover_hp(rate, set)
      effect(EFFECT_RECOVER_HP, 0, rate, set)
    end

    def recover_mp(rate, set)
      effect(EFFECT_RECOVER_MP, 0, rate, set)
    end

    def gain_tp(n)
      effect(EFFECT_GAIN_TP, 0, n, 0.0)
    end

    def add_state(id, rate)
      effect(EFFECT_ADD_STATE, id, rate, 0.0)
    end

    def rem_state(id, rate)
      effect(EFFECT_REMOVE_STATE, id, rate, 0.0)
    end

    def add_buff(param_id, turns)
      effect(EFFECT_ADD_BUFF, param_id, turns, 0.0)
    end

    def add_debuff(param_id, turns)
      effect(EFFECT_ADD_DEBUFF, param_id, turns, 0.0)
    end

    def rem_buff(param_id)
      effect(EFFECT_REMOVE_BUFF, param_id, 0.0, 0.0)
    end

    def rem_debuff(param_id)
      effect(EFFECT_REMOVE_DEBUFF, param_id, 0.0, 0.0)
    end

    def special(id, v1=0.0, v2=0.0)
      effect(EFFECT_SPECIAL, id, v1, v2)
    end

    def escape
      special(SPECIAL_EFFECT_ESCAPE)
    end

    def grow(param_id,n)
      effect(EFFECT_GROW, param_id, n, 0.0)
    end

    def learn_skill(skill_id)
      effect(EFFECT_LEARN_SKILL, skill_id, 0.0, 0.0)
    end

    def common_event(cid)
      effect(EFFECT_COMMON_EVENT, cid, 0.0, 0.0)
    end

    extend self
  end
end
