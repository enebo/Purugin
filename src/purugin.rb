require 'java'

$LOAD_PATH << 'plugins/Purugin.jar'

require 'bukkit/block'
require 'bukkit/location'
require 'bukkit/plugin'
require 'bukkit/block/block'
require 'bukkit/command/player'
require 'bukkit/entity/entity'
require 'bukkit/entity/player'
require 'bukkit/event/player'
require 'bukkit/util/config'
require 'bukkit/util/vector'
require 'purugin/colors'
require 'purugin/plugin'

$plugins = []

module Purugin
  class Purugin
    include ::Purugin::Base
    
    def on_load
      plugin_manager.load_plugins java.io.File.new("plugins")
    end

    def on_enable
      $plugins.each { |plugin| plugin_manager.enable_plugin plugin }
    end

    def on_disable
      $plugins.each { |plugin| plugin_manager.disable_plugin plugin }
    end
    
    def getDescription
      @plugin.get_description
    end
    
    def getConfiguration
      @plugin.get_configuration
    end
    
    def instantiate_plugin(plugin_loader, path)
      return unless $last_loaded
      plugin = $last_loaded.new(@plugin, plugin_loader, path)
      $last_loaded = nil;
      plugin
    end
  end
end

class Object
  def purugin(name, version, &code)
    cls = Class.new do
      include Purugin::Plugin
      description name, version      
    end
    cls.class_eval &code    
  end
end

Purugin::Purugin