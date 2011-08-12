require 'purugin/base'
require 'purugin/plugin_metadata'

module Purugin
  # This module is the main module you should include if you want to make a registered
  # Bukkit plugin.  It will actually implement all the methods required by org.bukkit.plugin.Plugin.
  # Here is a simple example of making a plugin:
  #
  #   class PlayerJoinedPlugin
  #     include Purugin::Plugin
  #     description 'PlayerJoined', 0.1
  #
  #     def on_enable
  #       # Tell everyone in players world that they have joined
  #       event(:player_join) do |e|
  #         e.player.world.players.each do |p| 
  #           p.send_message "Player #{e.player.name} has joined"
  #       end
  #     end
  #   end
  #
  # This class will send a message to all users whenever a new player joins your world.  Note,
  # that by playing the above code into a .rb file in your CraftBukkits plugins directory will
  # automatically load this file on startup and instantiate the class you make which implements
  # Purugin::Plugin.
  module Plugin
    include Base, org.bukkit.plugin.Plugin
    # :nodoc:
    def self.included(other)
      other.extend(PluginMetaData)
      $last_loaded = other
    end

    # :nodoc:
    def initialize(plugin, plugin_manager, path)
      super(plugin, plugin_manager)
      $plugins << self
      @plugin_description = org.bukkit.plugin.PluginDescriptionFile.new self.class.plugin_name, self.class.plugin_version.to_s, 'none'
      @data_dir = File.dirname(path) + '/' + self.class.plugin_name
      Dir.mkdir @data_dir unless File.exist? @data_dir
      @configuration = org.bukkit.util.config.Configuration.new java.io.File.new(@data_dir, 'config.yml')
      @required_plugins = self.class.required_plugins
      @optional_plugins = self.class.optional_plugins
    end

    # bukkit Plugin impl (see Bukkit API documentation)
    def getDescription
      @plugin_description
    end

    # bukkit Plugin impl (see Bukkit API documentation)
    # 
    # As a Ruby plugin you can store whatever you want in this directory (marshalled data,
    # YAML, library of congress as CSV file).
    def getDataFolder
      @data_dir
    end
    alias :data_folder :getDataFolder
    
    # bukkit Plugin impl (see Bukkit API documentation)    
    def getConfiguration
      @configuration
    end
    alias :configuration :getConfiguration
    
    # Convenience method for getting the Java loaded version of a loaded YAML file (each
    # Bukkit plugin may have it's own YAML file for config data (see Bukkit documentation).
    def load_configuration
      config = getConfiguration
      config.load
      config
    end
  end
end

