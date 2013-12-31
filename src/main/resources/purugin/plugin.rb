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
    include Base, Command, Event, org.bukkit.plugin.Plugin
    
    # :nodoc:
    def self.included(other)
      other.extend(PluginMetaData)
      $last_loaded = other
    end

    # :nodoc:
    def initialize(plugin, plugin_manager, path)
      path.gsub!(/\\/, '/') # Wackiness until nicer plugin reg than $plugins (for win paths)
      @purugin_plugin, @plugin_loader = plugin, plugin_manager
      @server = plugin.server
      $plugins[path] = [self, File.mtime(path)]
      @plugin_description = org.bukkit.plugin.PluginDescriptionFile.new self.class.plugin_name, self.class.plugin_version.to_s, 'none'
      @data_dir = File.join(File.dirname(path), self.class.plugin_name)
      @config_file = File.join(@data_dir, 'config.yml')
      @configuration = Purugin::Config.new(self, loadConfig)
      @required_plugins = self.class.required_plugins
      @optional_plugins = self.class.optional_plugins
      @gems = self.class.gems
      @type_registry = Purugin::CommandParser::CommandTypeRegistry.new # Giving each plugin their registry to avoid collisions of popular names
    end
    
    # FIXME: Move into module for type coercion
    def coerce(type_name, sender, value)
      converter = @type_registry[type_name]
      
      error? converter, "Cannot find type converter: '#{type_name}'"
      
      converter.call(sender, value)
    end

    # bukkit Plugin impl (see Bukkit API documentation)
    # 
    # As a Ruby plugin you can store whatever you want in this directory (marshalled data,
    # YAML, library of congress as CSV file).
    def getDataFolder
      Dir.mkdir @data_dir unless File.exist? @data_dir
      @data_dir
    end
    alias :data_folder :getDataFolder
    
    # return the path to the gem directory and optionally create it if it has never
    # been accessed before
    def gem_directory
      purugin_dir = @purugin_plugin.getDataFolder.to_s
      Dir.mkdir purugin_dir unless File.exist? purugin_dir
      
      File.join(purugin_dir, 'gems').tap do |gem_dir|
        Dir.mkdir gem_dir unless File.exist? gem_dir
        ENV['GEM_HOME'] = gem_dir
      end
    end
    
    # bukkit Plugin impl (see Bukkit API documentation)
    def getDescription
      @plugin_description
    end    
    
    # bukkit Plugin impl (see Bukkit API documentation)    
    def getConfiguration
      @configuration.real_config
    end
    alias :configuration :getConfiguration
    
    # bukkit Plugin impl (see Bukkit API documentation) 
    def getPluginLoader
      @plugin_loader
    end
    
    # bukkit Plugin impl (see Bukkit API documentation)     
    def saveConfig
      config.real_config.save @config_file
    end
    
    # bukkit Plugin impl (see Bukkit API documentation)    
    def loadConfig
      org.bukkit.configuration.file.YamlConfiguration.load_configuration java.io.File.new(@config_file)
    end
    
    # bukkit Plugin impl (see Bukkit API documentation)
    def getLogger
      java.util.logging.Logger.getLogger(getName)
    end
    
    # bukkit Plugin impl (see Bukkit API documentation)
    def getServer
      server
    end
    
    # bukkit Plugin impl (see Bukkit API documentation) 
    def isEnabled
      @enabled
    end
    alias :enabled? :isEnabled
    
    # bukkit Plugin impl (see Bukkit API documentation) 
    def onDisable
      on_disable if respond_to? :on_disable
      @enabled = false
      printStateChange 'DISABLED'      
    end    
    
    # bukkit Plugin impl (see Bukkit API documentation)     
    def onLoad
      on_load if respond_to? :on_load
    end
    
    # bukkit Plugin impl (see Bukkit API documentation) 
    def onEnable
      @enabled = true
      process_gems(@gems)
      process_plugins(@required_plugins, true)
      process_plugins(@optional_plugins, false)
      on_enable if respond_to? :on_enable
      printStateChange 'ENABLED'
    end
    
    # bukkit Plugin impl (see Bukkit API documentation) 
    def isNaggable
      @naggable
    end

    # bukkit Plugin impl (see Bukkit API documentation) 
    def setNaggable(naggable)
      @naggable = naggable
    end
    
    def getDatabase
      nil
    end
    
    def getDefaultWorldGenerator(string, string1)
      nil
    end
    
    def getName
      self.class.plugin_name
    end    

    # Write a message to the console
    alias :console :print

    # Used to display modules lifecycle state changes to the CraftBukkit console.
    def printStateChange(state)
      description = getDescription
      console "[#{description.name}] version #{description.version} #{state}"
    end
    
    # This method will ask for a plugin of name plugin_name and then look for a module
    # of name plugin_module and include it into your plugin.  This method should be used
    # in your on_enable method (see examples/admin.rb for usage).
    def include_plugin_module(plugin_name, plugin_module)
      plugin = plugin_manager[plugin_name] # Try and get full java registered plugin first
      unless plugin
        puts "Unable to find plugin #{plugin_name}...ignoring"
        return
      end
      
      include_module_from(plugin, plugin_module)
    end
    
    def process_gems(gems)
      if !gems.empty?
        require 'rubygems' # FIXME: Once we switch to 1.7.x 1.9 is default and we don't need this
        Gem.paths = {'GEM_HOME' => gem_directory}
      end
      
      gems.each do |gem_name, options|
        # FIXME: Add processing of options
        begin
          gem gem_name
        rescue LoadError
          system "gem install #{gem_name} --verbose --install-dir #{gem_directory}"
          
          begin
            gem gem_name
          rescue LoadError => e
            console "unable to load gem: #{gem_name}"
            raise e
          end
        end
      end
    end
    
    def process_plugins(list, required)
      return unless list
      
      list.each do |name, options|
        plugin = plugin_manager[name.to_s]
        
        if !plugin && required
          raise MissingDependencyError.new "Plugin #{name} not found for plugin #{description.name}"
        end

        # Make convenience method for plugin 
        # TODO: Resolve what happens if plugin conflicts w/ existing method)
        self.class.send(:define_method, name.to_s) { plugin }
        process_includes plugin, options[:include] if options[:include]
        process_services plugin, options[:services] if options[:services]
      end
    end
    private :process_plugins
    
    def process_includes(plugin, includes)
      if includes.respond_to? :to_ary
        includes.to_ary.each { |const| include_module_from(plugin, const) }
      else
        include_module_from(plugin, includes)
      end
    end
    private :process_includes
    
    ##
    # Retrieves each requested service that the plugin wants and then saves the retrieved
    # service as an instance variable accessiable via a reader using the provided bind_method.
    # === Examples
    # require :Vault, :services => {"net.milkbowl.vault.economy.Economy" => :economy}
    def process_services(plugin, services)
      services.each do |bind_method, service_class_name|
        service_class = plugin.class_loader.find_class service_class_name
        service_provider = server.services_manager.get_registration(service_class)
        if !service_provider
          raise MissingDependencyError.new "Cannot load provider for #{service_class_name} (none exist?)"
        end
        bind_variable = '@' + bind_method.to_s
        self.instance_variable_set bind_variable, service_provider.provider
        self.class.__send__ :attr_reader, bind_method.to_s
      end
    end
    private :process_services
    
    def include_module_from(plugin, name)
      unless plugin.class.const_defined? name
        raise MissingDependencyError.new "Module #{name} not found in plugin #{plugin.getDescription.name}"
      end
      
      self.class.__send__ :include, plugin.class.const_get(name)
    end
    
    def config
      @configuration
    end
  end
end