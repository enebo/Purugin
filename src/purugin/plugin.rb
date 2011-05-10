require 'purugin/base'
require 'purugin/plugin_metadata'

module Purugin
  module Plugin
    include Base, org.bukkit.plugin.Plugin
    
    def self.included(other)
      other.extend(PluginMetaData)
      $last_loaded = other
    end

    def initialize(plugin, plugin_manager, path)
      super(plugin, plugin_manager)
      $plugins << self
      @plugin_description = org.bukkit.plugin.PluginDescriptionFile.new self.class.plugin_name, self.class.plugin_version.to_s, 'none'
      @data_dir = File.dirname(path) + '/' + self.class.plugin_name
      Dir.mkdir @data_dir unless File.exist? @data_dir
      @configuration = org.bukkit.util.config.Configuration.new java.io.File.new(@data_dir, 'config.yml')
    end

    def getDescription
      @plugin_description
    end
    
    def getDataFolder
      @data_dir
    end
    alias :data_folder :getDataFolder
    
    def getConfiguration
      @configuration
    end
    alias :configuration :getConfiguration
    
    def load_configuration
      config = getConfiguration
      config.load
      config
    end
  end
end

