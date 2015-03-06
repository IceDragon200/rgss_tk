require "rgss_tk/db/database"
require "rgss_tk/make_effect"
require "rgss_tk/make_feature"
require "rgss_tk/const"

module RgssTk
  class Database
    module DSL
      def damage_type(sym = nil)
        case sym
        when :none              then 0
        when :hp_damage,   :hpd then 1
        when :mp_damage,   :mpd then 2
        when :hp_recovery, :hpr then 3
        when :mp_recovery, :mpr then 4
        when :hp_absorb,   :hpa then 5
        when :mp_absorb,   :mpa then 6
        else
          0
        end
      end

      def hit_type(sym = nil)
        case sym
        when :certain then  0
        when :physical then 1
        when :magical then  2
        else
          0
        end
      end

      def occasion(sym = nil)
        case sym
        when :always then 0
        when :battle then 1
        when :menu   then 2
        when :never  then 3
        else
          3
        end
      end

      def scope(sym = nil)
        case sym
        when :none, nil
          Const::SCOPE_NONE
        when :one_enemy
          Const::SCOPE_ONE_ENEMY
        when :all_enemies
          Const::SCOPE_ALL_ENEMIES
        when :random_enemy1
          Const::SCOPE_RANDOM_ENEMY1
        when :random_enemy2
          Const::SCOPE_RANDOM_ENEMY2
        when :random_enemy3
          Const::SCOPE_RANDOM_ENEMY3
        when :random_enemy4
          Const::SCOPE_RANDOM_ENEMY4
        when :one_ally
          Const::SCOPE_ONE_ALLY
        when :all_allies
          Const::SCOPE_ALL_ALLIES
        when :one_ally_koed
          Const::SCOPE_ONE_ALLY_KOED
        when :all_allies_koed
          Const::SCOPE_ALL_ALLIES_KOED
        when :user
          Const::SCOPE_USER
        else
          Const::SCOPE_NONE
        end
      end

      def mkeff
        MakeEffect
      end

      def mkfet
        MakeFeature
      end

      def db
        database = Database.new
        yield database if block_given?
        return database
      end
    end
  end
end
