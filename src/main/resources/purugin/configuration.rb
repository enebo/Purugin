require 'delegate'

module Purugin
  ##
  # Make simple delegating wrapper around actual config object
  # since minecraft config object does not know how to persist.
  # A Purugin's config method will return an instance of this.
  class Config < SimpleDelegator
    attr_reader :real_config
    
    def initialize(plugin, real_config)
      super(real_config)

      @plugin, @real_config = plugin, real_config
    end
    
    ##
    # save this configuration object
    def save
      @plugin.saveConfig
    end
    
    ##
    # load this configuration object
    def load
      @plugin.loadConfig
    end
  
    def get!(path, default_value)
      value = get path
      value = set! path, default_value unless value
      value
    end
    
    def create_section(path, map={})
      new @plugin, createSection(path, map)
    end
    
    def get_configuration_section(path)
      new @plugin, getConfigurationSection(path)
    end
    
    def get_default_section
      new @plugin, getDefaultSection
    end
  
    def get_boolean!(path, default_value)
      set! path, get_boolean(path, default_value)
    end
  
    def get_float!(path, default_value)
      set! path, get_double(path, default_value)
    end
  
    def get_fixnum!(path, default_value)
      set! path, get_int(path, default_value)
    end
  
    def get_string!(path, default_value)
      set! path, get_string(path, default_value)
    end
  
    # Once setProperty/removeProperty is called also save this Configuration
    def set!(path, value)
      set path, value
      save
      value
    end
  
    def remove!(path)
      remove path
      save
      path
    end    
  end
end
