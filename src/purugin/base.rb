require 'purugin/event'

module Purugin
  # This is common code used by both Purugin::Plugin and Purugin::Purugin (plugin which loads
  # all Purugin::Plugins).  A majority of these methods are just required API method for 
  # org.bukkit.Plugin interface in Java.
  # 
  # The methods you should care about are ones which these methods will call.  For example,
  # if you make a plugin you will need to provide an on_load method to actually load anything
  # once your plugin has loaded.  The on_load method is in fact called from this modules onLoad
  # method (which satisfies one of the lifecycle methods of org.bukkit.Plugin).  The other 
  # interesting lifecycle methods are: on_load, on_enable, and on_disable.
  # 
  # Additionally, there are a couple of useful methods which as a plugin author you will be
  # accessing a lot: server, plugin_manager
  #
  # Finally, if you want one plugin you implemented to access a module from a second plugin
  # look at 'include_plugin_module'.  We require a special method since we cannot include 
  # modules directly since we don't know when the other module has been loaded.  You will call
  # this method from within your on_enable method.
  module Base
    include Purugin::Event

    attr_reader :plugin

    def initialize(plugin, plugin_loader)
      @plugin, @plugin_loader = plugin, plugin_loader
      @ruby_plugins = {} # Plugins not register in bukkit, but Ruby purugins can see them.
    end

    # A reference to the CraftBukkit server
    def server
      @plugin.server
    end
    
    # A reference to the CraftBukkit plugin_manager.  This is useful for when you want to
    # get a live reference to another Bukkit plugin (Ruby or otherwise).
    def plugin_manager
      server.plugin_manager
    end

    # bukkit Plugin impl (see Bukkit API documentation)     
    def onLoad
      on_load if respond_to? :on_load
    end
    
    # bukkit Plugin impl (see Bukkit API documentation) 
    def onEnable
      @enabled = true
      on_enable if respond_to? :on_enable
      printStateChange 'ENABLED'
    end

    # bukkit Plugin impl (see Bukkit API documentation) 
    def onDisable
      on_disable if respond_to? :on_disable
      @enabled = false
      printStateChange 'DISABLED'      
    end
    
    # bukkit Plugin impl (see Bukkit API documentation) 
    def isEnabled
      @enabled
    end
    alias :enabled? :isEnabled

    # bukkit Plugin impl (see Bukkit API documentation) 
    def getPluginLoader
      @plugin_loader
    end
    
    # bukkit Plugin impl (see Bukkit API documentation) 
    def isNaggable
      @naggable
    end

    # bukkit Plugin impl (see Bukkit API documentation) 
    def setNaggable(naggable)
      @naggable = naggable
    end

    # Used to display modules lifecycle state changes to the CraftBukkit console.
    def printStateChange(state)
      description = getDescription
      puts "[#{description.name}] version #{description.version} #{state}"
    end
    
    # This method will ask for a plugin of name plugin_name and then look for a module
    # of name plugin_module and include it into your plugin.  This method should be used
    # in your on_enable method (see examples/admin.rb for usage).
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
