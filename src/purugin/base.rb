require 'purugin/event'
require 'purugin/errors'

module Purugin
  # This is common code used by both Purugin::Plugin and Purugin::Purugin (plugin which loads
  # all Purugin::Plugins).
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
    attr_reader :server
    
    # A reference to the CraftBukkit plugin_manager.  This is useful for when you want to
    # get a live reference to another Bukkit plugin (Ruby or otherwise).
    def plugin_manager
      server.plugin_manager
    end
  end
end
