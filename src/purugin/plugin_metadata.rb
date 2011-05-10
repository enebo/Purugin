module Purugin  
  module PluginMetaData
    def description(name, version)
      @@name, @@version = name, version
    end
    
    def plugin_name
      @@name || self.class.name
    end
    
    def plugin_version
      @@version || '0.1'
    end
  end
end
