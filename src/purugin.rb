require 'java'

# jar:file:/Users/enebo/work/minecraft/plugins/purugin.jar!/purugin.rb
purugin_jar_path = __FILE__.gsub(/(^jar:file:|!.*$)/, '')

$LOAD_PATH << purugin_jar_path

require 'bukkit'
require 'bukkit/permissions'
require 'bukkit/event/player'
require 'bukkit/util'
require 'purugin/change_listener'
require 'purugin/colors'
require 'purugin/command'
require 'purugin/plugin'

$plugins = {} # path => [purugin, time_loaded]

module Purugin
  # Because of some weird classloading issues we define this proxy instead of adorning the
  # actual Java PuruginPlugin class.  PuruginPlugin calls through to this to do any work
  # implemented in Ruby.
  class PuruginProxy
    PURUGINS_GLOB = "plugins/*.rb"
    include Purugin::Base

    attr_accessor :ruby_plugin_loader
    
    def initialize(plugin, plugin_loader)
      @purugin_plugin, @plugin_loader = plugin, plugin_loader
      @server = @purugin_plugin.server
    end
    
    def onLoad
      Dir[PURUGINS_GLOB].each do |f|
        plugin_manager.load_plugin java.io.File.new(f)
      end
    end

    def onEnable
      $plugins.each { |_, (plugin, _)| plugin_manager.enable_plugin plugin }
      Thread.new { ChangeListener.new(self, PURUGINS_GLOB).listen }
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