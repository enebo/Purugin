module Purugin  
  ##
  # This module provides the methods used by a Purugin::Plugin to describe information
  # about the plugin you are making.
  module PluginMetaData
    ##
    # Provide the name and version of the plugin.
    # The version may be a string or an integer.  It is unclear whether bukkit
    # has strong requirements on what a version is.
    def description(name, version)
      @name, @version = name, version
    end
    
    ##
    # Used internally by a plugin to get the plugin's name set by description
    def plugin_name
      @name || self.class.name
    end
    
    ##
    # Used internallt by a plugin to get the plugin's version set by description
    def plugin_version
      @version || '0.1'
    end
    
    ##
    # Provide a dependency requirement for your plugin. This will also create a method with the
    # same name of the plugin_name so that you can easily reference a live reference to the plugin.
    # opts can include:
    # * include -> a list of modules to include
    def required(plugin_name, options = {})
      required_plugins[plugin_name.to_s] = options
    end

    ##
    # Provide an optional dependency for your plugin. This will also create a method with the
    # same name of the plugin_name so that you can easily reference a live reference to the plugin.
    # opts can include:
    # * include -> a list of modules to include    
    def optional(plugin_name, options = {})
      optional_plugins[plugin_name.to_s] = options
    end
    
    ##
    # Specify that a particular gem is required for this Purugin to function properly.  At 
    # load-time if the purugin is unable to detect the gem's existence it will try and install
    # the gem locally.
    def gem(gem_name, options = {})
      gems[gem_name.to_s] = options
    end
    
    def required_plugins
      @required_plugins ||= {}
    end
    
    def optional_plugins
      @optional_plugins ||= {}
    end
    
    def gems
      @gems ||= {}
    end
  end
end
