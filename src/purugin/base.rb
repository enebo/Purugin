require 'purugin/event'

module Purugin
  module Base
    include Purugin::Event

    attr_reader :plugin

    def initialize(plugin, plugin_loader)
      @plugin, @plugin_loader = plugin, plugin_loader
      @ruby_plugins = {} # Plugins not register in bukkit, but Ruby purugins can see them.
    end

    def server
      @plugin.server
    end
    
    def plugin_manager
      server.plugin_manager
    end

    def onLoad
      on_load if respond_to? :on_load
    end

    def onEnable
      @enabled = true
      on_enable if respond_to? :on_enable
      printStateChange 'ENABLED'
    end

    def onDisable
      on_disable if respond_to? :on_disable
      @enabled = false
      printStateChange 'DISABLED'      
    end

    def isEnabled
      @enabled
    end

    def getPluginLoader
      @plugin_loader
    end

    def isNaggable
      @naggable
    end

    def setNaggable(naggable)
      @naggable = naggable
    end
    
    def printStateChange(state)
      description = getDescription
      puts "[#{description.name}] version #{description.version} #{state}"
    end
    
    def include_plugin_module(plugin_name, plugin_module)
      plugin = plugin_manager[plugin_name] # Try and get full java registered plugin first
      unless plugin
        plugin = @ruby_plugins[plugin_name] # Look in reloadable plugins
        unless plugin
          puts "Unable to find plugin #{plugin_name}...ignoring"
          return
        end
      end
      
      mod = plugin.class.const_get plugin_module
      unless mod
        puts "Unabled to load module #{plugin_module} from #{plugin_name}"
        return
      end
      
      self.class.__send__ :include, mod
    end
  end
end
