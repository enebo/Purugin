require 'java'

# jar:file:/Users/enebo/work/minecraft/plugins/purugin.jar!/purugin.rb
purugin_jar_path = __FILE__.gsub(/(^jar:file:|!.*$)/, '')
puts purugin_jar_path

$LOAD_PATH << purugin_jar_path

require 'bukkit'
require 'bukkit/block/block'
require 'bukkit/command'
require 'bukkit/permissions'
require 'bukkit/event/player'
require 'bukkit/util'
require 'purugin/change_listener'
require 'purugin/colors'
require 'purugin/command'
require 'purugin/plugin'

$plugins = {} # path => [purugin, time_loaded]

module Purugin
  class Purugin
    PURUGINS_GLOB = "plugins/*.rb"
    include ::Purugin::Base
    
    def on_load
      Dir[PURUGINS_GLOB].each do |f|
        plugin_manager.load_plugin java.io.File.new(f)
      end
    end

    def on_enable
      $plugins.each { |_, (plugin, _)| plugin_manager.enable_plugin plugin }
      Thread.new { ChangeListener.new(self, PURUGINS_GLOB).listen }
    end

    def on_disable
      $plugins.each { |_, (plugin, _)| plugin_manager.disable_plugin plugin }
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
      $last_loaded = nil
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
