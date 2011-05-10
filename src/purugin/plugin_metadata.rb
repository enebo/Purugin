module Purugin  
  # This module provides the methods used by a Purugin::Plugin to describe information
  # about the plugin you are making.
  module PluginMetaData
    # Provide the name and version of the plugin.
    # The version may be a string or an integer.  It is unclear whether bukkit
    # has strong requirements on what a version is.
    def description(name, version)
      @@name, @@version = name, version
    end
    
    # Used internally by a plugin to get the plugin's name set by description
    def plugin_name
      @@name || self.class.name
    end
    
    # Used internallt by a plugin to get the plugin's version set by description
    def plugin_version
      @@version || '0.1'
    end
  end
end
