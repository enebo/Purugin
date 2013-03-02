# jar:file:/Users/enebo/work/minecraft/plugins/purugin.jar!/purugin.rb
purugin_jar_path = __FILE__.gsub(/(^jar:file:|!.*$)/, '')

$LOAD_PATH << purugin_jar_path

require 'java'
require 'purugin/utils/conversion_util'
require 'purugin/predicate'
require 'bukkit/block/biome'
require 'bukkit/block/block'
require 'bukkit/command/command'
require 'bukkit/command/command_sender'
require 'bukkit/entity/entity'
require 'bukkit/entity/human_entity'
require 'bukkit/entity/living_entity'
require 'bukkit/event/entity/creeper_power_event'
require 'bukkit/event/entity/creature_spawn_event'
require 'bukkit/event/entity/entity_damage_event'
require 'bukkit/event/entity/entity_regain_health_event'
require 'bukkit/event/entity/entity_target_event'
require 'bukkit/event/painting/painting_break_event'
require 'bukkit/event/player'
require 'bukkit/event/player/player_fish_event'
require 'bukkit/event/player/player_login_event'
require 'bukkit/event/player/player_pre_login_event'
require 'bukkit/game_mode'
require 'bukkit/location'
require 'bukkit/material'
require 'core_ext/symbol'
require 'bukkit/permissions/permissible'
require 'bukkit/plugin/plugin_manager'
require 'bukkit/plugin/simple_plugin_manager'
require 'bukkit/event/player'
require 'bukkit/util/vector'
require 'bukkit/world'
require 'purugin/change_listener'
require 'purugin/colors'
require 'purugin/command'
require 'purugin/configuration'
require 'purugin/items'
require 'purugin/plugin'
require 'purugin/recipes'
require 'purugin/tasks'

$plugins = {} # path => [purugin, time_loaded]

module Purugin
  # Because of some weird classloading issues we define this proxy instead of adorning the
  # actual Java PuruginPlugin class.  PuruginPlugin calls through to this to do any work
  # implemented in Ruby.
  class PuruginProxy
    PURUGINS_GLOB = "plugins/*.rb"
    include Purugin::Base

    attr_accessor :ruby_plugin_loader
    
    def initialize(plugin, plugin_loader, purugin_path)
      @purugin_plugin, @plugin_loader = plugin, plugin_loader
      @server = @purugin_plugin.server
      @purugins_glob = File.join(purugin_path, "*.rb")
    end
    
    def onLoad
      Dir[@purugins_glob].each do |f|
        plugin_manager.load_plugin java.io.File.new(f)
      end
    end

    def onEnable
      $plugins.each { |_, (plugin, _)| plugin_manager.enable_plugin plugin }
      Thread.new { ChangeListener.new(self, @purugins_glob).listen }
    end

    def onDisable
      $plugins.each { |_, (plugin, _)| plugin_manager.disable_plugin plugin }
    end
    
    def instantiate_plugin(path)
      return unless $last_loaded
      plugin = $last_loaded.new(@purugin_plugin, ruby_plugin_loader, path)
      $last_loaded = nil
      plugin
    end
  end
end

Purugin::PuruginProxy
