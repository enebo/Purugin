# This is a little out of control for now...but all of this is in one file until
# I get jruby-complete integrations into Purugin.jar.

require 'java'

module Purugin
  module Materials
    M = org.bukkit.Material
    MATERIAL_NAMES = {
      :air => M::AIR, :stone => M::STONE, :grass => M::GRASS, :dirt => M::DIRT,
      :cobbleston => M::COBBLESTONE, :wood => M::WOOD, :sapling => M::SAPLING,
      :bedrock => M::BEDROCK, :water => M::WATER, :stationary_water => M::STATIONARY_WATER,
      :lava => M::LAVA, :stationary_lava => M::STATIONARY_LAVA, :sand => M::SAND,
      :gravel => M::GRAVEL, :gold_ore => M::GOLD_ORE, :iron_ore => M::IRON_ORE,
      :coal_ore => M::COAL_ORE, :log => M::LOG, :leaves => M::LEAVES, :sponge => M::SPONGE,
      :glass => M::GLASS, :lapis_ore => M::LAPIS_ORE, :lapis_block => M::LAPIS_BLOCK,
      :dispenser => M::DISPENSER, :sandstone => M::SANDSTONE, :note_block => M::NOTE_BLOCK,
      :bed_block => M::BED_BLOCK, :powered_rail => M::POWERED_RAIL, :detector_rail => M::DETECTOR_RAIL,
      :web => M::WEB, :wool => M::WOOL, :yellow_flower => M::YELLOW_FLOWER, :red_rose => M::RED_ROSE,
      :brown_mushroom => M::BROWN_MUSHROOM, :red_mushroom => M::RED_MUSHROOM,
      :gold_block => M::GOLD_BLOCK, :iron_block => M::IRON_BLOCK, :double_step => M::DOUBLE_STEP,
      :step => M::STEP, :brick => M::BRICK, :tnt => M::TNT, :bookshelf => M::BOOKSHELF,
      :mossy_cobblestone => M::MOSSY_COBBLESTONE, :obsidian => M::OBSIDIAN,
      :torch => M::TORCH, :fire => M::FIRE, :mob_spawner => M::MOB_SPAWNER, :wood_stairs => M::WOOD_STAIRS,
      :chest => M::CHEST, :redstone_wire => M::REDSTONE_WIRE, :diamond_ore => M::DIAMOND_ORE,
      :diamond_block => M::DIAMOND_BLOCK, :workbench => M::WORKBENCH, :crops => M::CROPS,
      :soil => M::SOIL, :furnace => M::FURNACE, :burning_furnace => M::BURNING_FURNACE,
      :sign_post => M::SIGN_POST, :wooden_door => M::WOODEN_DOOR, :ladder => M::LADDER,
      :rails => M::RAILS, :cobblestone_stairs => M::COBBLESTONE_STAIRS,
      :wall_sign => M::WALL_SIGN, :lever => M::LEVER, :stone_plate => M::STONE_PLATE,
      :iron_door_block => M::IRON_DOOR_BLOCK, :wood_plate => M::WOOD_PLATE,
      :redstone_ore => M::REDSTONE_ORE, :glowing_redstone_ore => M::GLOWING_REDSTONE_ORE,
      :redstone_torch_off => M::REDSTONE_TORCH_OFF, :redstone_torch_on => M::REDSTONE_TORCH_ON,
      :stone_button => M::STONE_BUTTON, :snow => M::SNOW, :ice => M::ICE,
      :snow_block => M::SNOW_BLOCK, :cactus => M::CACTUS, :clay => M::CLAY,
      :sugar_cane_block => M::SUGAR_CANE_BLOCK, :jukebox => M::JUKEBOX, :fence => M::FENCE,
      :pumpkin => M::PUMPKIN, :netherrack => M::NETHERRACK, :soul_sand => M::SOUL_SAND,
      :glowstone => M::GLOWSTONE, :portal => M::PORTAL, :jack_o_lantern => M::JACK_O_LANTERN,
      :cake_block => M::CAKE_BLOCK, :diode_block_off => M::DIODE_BLOCK_OFF,
      :diode_block_on => M::DIODE_BLOCK_ON, :locked_chest => M::LOCKED_CHEST,
      # items
      :iron_spade => M::IRON_SPADE, :iron_pickaxe => M::IRON_PICKAXE,  :iron_axe => M::IRON_AXE,
      :flint_and_steel => M::FLINT_AND_STEEL, :apple => M::APPLE, :bow => M::BOW, :arrow => M::ARROW,
      :coal => M::COAL, :diamond => M::DIAMOND, :iron_ingot => M::IRON_INGOT, :gold_ingot => M::GOLD_INGOT,
      :iron_sword => M::IRON_SWORD, :wood_sword => M::WOOD_SWORD, :wood_spade => M::WOOD_SPADE,
      :wood_pickaxe => M::WOOD_PICKAXE, :wood_axe => M::WOOD_AXE, :stone_sword => M::STONE_SWORD,
      :stone_spade => M::STONE_SPADE, :stone_pickaxe => M::STONE_PICKAXE, :stone_axe => M::STONE_AXE,
      :diamond_sword => M::DIAMOND_SWORD, :diamond_spade => M::DIAMOND_SPADE,
      :diamond_pickaxe => M::DIAMOND_PICKAXE, :diamond_axe => M::DIAMOND_AXE, :stick => M::STICK,
      :bowl => M::BOWL, :mushroom_soup => M::MUSHROOM_SOUP, :gold_sword => M::GOLD_SWORD,
      :gold_spade => M::GOLD_SPADE, :gold_pickaxe => M::GOLD_PICKAXE, :gold_axe => M::GOLD_AXE,
      :string => M::STRING, :feather => M::FEATHER, :sulphur => M::SULPHUR, :wood_hoe => M::WOOD_HOE,
      :stone_hoe => M::STONE_HOE, :iron_hoe => M::IRON_HOE, :diamond_hoe => M::DIAMOND_HOE,
      :gold_hoe => M::GOLD_HOE, :seeds => M::SEEDS, :wheat => M::WHEAT, :bread => M::BREAD,
      :leather_helmet => M::LEATHER_HELMET, :leather_chestplate => M::LEATHER_CHESTPLATE,
      :leather_leggings => M::LEATHER_LEGGINGS, :leather_boots => M::LEATHER_BOOTS,
      :chainmail_helmet => M::CHAINMAIL_HELMET, :chainmail_chestplate => M::CHAINMAIL_CHESTPLATE,
      :chainmail_leggings => M::CHAINMAIL_LEGGINGS, :chainmail_boots => M::CHAINMAIL_BOOTS,
      :iron_helmet => M::IRON_HELMET, :iron_chestplate => M::IRON_CHESTPLATE,
      :iron_leggings => M::IRON_LEGGINGS, :iron_boots => M::IRON_BOOTS,
      :diamond_helmet => M::DIAMOND_HELMET, :diamond_chestplate => M::DIAMOND_CHESTPLATE,
      :diamond_leggings => M::DIAMOND_LEGGINGS, :diamond_boots => M::DIAMOND_BOOTS,
      :gold_helmet => M::GOLD_HELMET, :gold_chestplate => M::GOLD_CHESTPLATE,
      :gold_leggings => M::GOLD_LEGGINGS, :gold_boots => M::GOLD_BOOTS,
      :flint => M::FLINT, :pork => M::PORK, :grilled_pork => M::GRILLED_PORK,
      :painting => M::PAINTING, :golden_apple => M::GOLDEN_APPLE, :sign => M::SIGN,
      :wood_door => M::WOOD_DOOR, :bucket => M::BUCKET, :water_bucket => M::WATER_BUCKET,
      :lava_bucket => M::LAVA_BUCKET, :minecard => M::MINECART, :saddle => M::SADDLE,
      :iron_door => M::IRON_DOOR, :redstone => M::REDSTONE, :snow_ball => M::SNOW_BALL, :boat => M::BOAT,
      :leather => M::LEATHER, :milk_bucket => M::MILK_BUCKET, :clay_brick => M::CLAY_BRICK,
      :clay_ball => M::CLAY_BALL, :sugar_cane => M::SUGAR_CANE, :paper => M::PAPER, :book => M::BOOK,
      :slime_ball => M::SLIME_BALL, :storage_minecart => M::STORAGE_MINECART,
      :powered_minecart => M::POWERED_MINECART, :egg => M::EGG, :compass => M::COMPASS,
      :fishing_rod => M::FISHING_ROD, :watch => M::WATCH, :glowstone_dust => M::GLOWSTONE_DUST,
      :raw_fish => M::RAW_FISH, :cooked_fish => M::COOKED_FISH, :ink_sack => M::INK_SACK,
      :bone => M::BONE, :sugar => M::SUGAR, :cake => M::CAKE, :bed => M::BED, :diode => M::DIODE,
      :cookie => M::COOKIE, :gold_record => M::GOLD_RECORD, :green_record => M::GREEN_RECORD
    }
    
    def is?(value)
      self.type == MATERIAL_NAMES[value]
    end  
  end
end

module org::bukkit::block::Block
  include Purugin::Materials
  BF = org.bukkit.block.BlockFace
  FACE_VALUES = {
    :north => BF::NORTH, :east => BF::EAST, :south => BF::SOUTH, :west => BF::WEST,
    :up => BF::UP, :down => BF::DOWN, :north_east => BF::NORTH_EAST, :north_west => BF::NORTH_WEST,
    :ne => BF::NORTH_EAST, :nw => BF::NORTH_WEST, :south_east => BF::SOUTH_EAST, 
    :south_west => BF::SOUTH_WEST, :se => BF::SOUTH_EAST, :sw => BF::SOUTH_WEST, :self => BF::SELF
  }
  
  def block_at(face_value)
    face = face_for(face_value)
    get_face(face)
  end
  
  def face_for(value)
    FACE_VALUES[value]
  end
  private :face_for
end

module org::bukkit::plugin::PluginManager
  def [](plugin_name)
    getPlugin(plugin_name)
  end
end

class org::bukkit::util::config::ConfigurationNode
  # Once setProperty is called also save this Configuration
  def set!(path, value)
    setProperty(path, value)
    save
  end
end

$plugins = []

module Purugin
  BukkitEvent = org.bukkit.event.Event

  module Event
    T = org.bukkit.event.Event::Type

    
    module ProcLogic
      def self.included(other)
        other.extend(EventAliases)
      end
      
      def initialize(&proc)
        super()
        @proc = proc
      end

      def onEvent(event)
        @proc.call(event)
      end      
    end
    
    module EventAliases
      def handlers(*names)
        names.each { |name| alias_method name, :onEvent }
      end
    end
    
    class ProcBlockListener < org.bukkit.event.block.BlockListener
      include ProcLogic
      handlers :onBlockDamage, :onBlockCanBuild, :onBlockFromTo, :onBlockFlow,
        :onBlockIgnite, :onBlockPhysics, :onBlockPlace, :onBlockRedstoneChange,
        :onLeavesDecay, :onSignChange, :onBlockBurn, :onBlockBreak
    end

    class ProcCustomEventListener < org.bukkit.event.CustomEventListener
      include ProcLogic
      handlers :onCustomEvent
    end

    class ProcEntityListener < org.bukkit.event.entity.EntityListener
      include ProcLogic
      handlers :onCreatureSpawn, :onEntityCombust, :onEntityDamage,
        :onEntityExplode, :onExplosionPrime, :onEntityDeath,
        :onEntityTarget, :onEntityInteract
    end

    class ProcPlayerListener < org.bukkit.event.player.PlayerListener
      include ProcLogic
      handlers :onPlayerJoin, :onPlayerQuit, :onPlayerKick, :onPlayerChat,
        :onPlayerCommandPreprocess, :onPlayerMove, :onPlayerTeleport,
        :onPlayerRespawn, :onPlayerInteract, :onPlayerLogin,
        :onPlayerEggThrow, :onPlayerAnimation, :onInventoryOpen,
        :onItemHeldChange, :onPlayerDropItem, :onPlayerPickupItem,
        :onPlayerToggleSneak, :onPlayerBucketFill, :onPlayerBucketEmpty,
        :onPlayerQuit, :onPlayerCommandPreprocess, :onPlayerTeleport,
        :onPlayerJoin
    end

    class ProcServerListener < org.bukkit.event.server.ServerListener
      include ProcLogic
      handlers :onPluginEnable, :onPluginDisable, :onServerCommand
    end

    class ProcVehicleListener < org.bukkit.event.vehicle.VehicleListener
      include ProcLogic
      handlers :onVehicleCreate, :onVehicleDamage, :onVehicleBlockCollision, 
        :onVehicleEntityCollision, :onVehicleEnter, :onVehicleExit, 
        :onVehicleMove, :onVehicleDestroy, :onVehicleUpdate
    end

    class ProcWeatherListener < org.bukkit.event.weather.WeatherListener
      include ProcLogic
      handlers :onWeatherChange, :onThunderChange, :onLightningStrike
    end

    class ProcWorldListener < org.bukkit.event.world.WorldListener
      include ProcLogic
      handlers :onChunkLoad, :onChunkUnload, :onSpawnChange,
        :onWorldSave, :onWorldLoad
    end

    EVENT_TO_LISTENER = {
      T::CHUNK_LOAD => ProcWorldListener, T::CHUNK_UNLOAD => ProcWorldListener,
      T::SPAWN_CHANGE => ProcWorldListener, T::WORLD_SAVE => ProcWorldListener,
      T::WORLD_LOAD => ProcWorldListener, T::BLOCK_BREAK => ProcBlockListener,
      T::BLOCK_BURN  => ProcBlockListener, T::BLOCK_CANBUILD => ProcBlockListener,
      T::BLOCK_DAMAGE => ProcBlockListener, T::BLOCK_FROMTO => ProcBlockListener,
      T::BLOCK_IGNITE => ProcBlockListener, T::BLOCK_PHYSICS => ProcBlockListener,
      T::BLOCK_PLACE => ProcBlockListener, T::LEAVES_DECAY => ProcBlockListener,
      T::REDSTONE_CHANGE => ProcBlockListener, T::SIGN_CHANGE => ProcBlockListener,
      T::CUSTOM_EVENT => ProcCustomEventListener, T::CREATURE_SPAWN => ProcEntityListener,
      T::ENTITY_COMBUST => ProcEntityListener, T::ENTITY_DAMAGE => ProcEntityListener,
      T::ENTITY_EXPLODE => ProcEntityListener, T::EXPLOSION_PRIME => ProcEntityListener,
      T::ENTITY_DEATH => ProcEntityListener, T::ENTITY_TARGET => ProcEntityListener,
      T::ENTITY_INTERACT => ProcEntityListener, T::PLAYER_JOIN => ProcPlayerListener,
      T::PLAYER_QUIT => ProcPlayerListener, T::PLAYER_KICK => ProcPlayerListener,
      T::PLAYER_CHAT => ProcPlayerListener, T::PLAYER_COMMAND_PREPROCESS => ProcPlayerListener,
      T::PLAYER_MOVE => ProcPlayerListener, T::PLAYER_TELEPORT => ProcPlayerListener,
      T::PLAYER_RESPAWN => ProcPlayerListener, T::PLAYER_INTERACT => ProcPlayerListener,
      T::PLAYER_LOGIN => ProcPlayerListener, T::PLAYER_EGG_THROW => ProcPlayerListener,
      T::PLAYER_ANIMATION => ProcPlayerListener, T::INVENTORY_OPEN => ProcPlayerListener,
      T::PLAYER_ITEM_HELD => ProcPlayerListener, T::PLAYER_DROP_ITEM => ProcPlayerListener,
      T::PLAYER_PICKUP_ITEM => ProcPlayerListener, T::PLAYER_TOGGLE_SNEAK => ProcPlayerListener,
      T::PLAYER_BUCKET_FILL => ProcPlayerListener, T::PLAYER_BUCKET_EMPTY => ProcPlayerListener,
      T::PLAYER_QUIT => ProcPlayerListener, T::PLUGIN_ENABLE => ProcServerListener,
      T::PLUGIN_DISABLE => ProcServerListener, T::SERVER_COMMAND => ProcServerListener,
      T::VEHICLE_CREATE => ProcVehicleListener, T::VEHICLE_DAMAGE => ProcVehicleListener,
      T::VEHICLE_COLLISION_BLOCK => ProcVehicleListener, T::VEHICLE_COLLISION_ENTITY => ProcVehicleListener,
      T::VEHICLE_ENTER => ProcVehicleListener, T::VEHICLE_EXIT => ProcVehicleListener,
      T::VEHICLE_MOVE => ProcVehicleListener, T::VEHICLE_DESTROY => ProcVehicleListener,
      T::VEHICLE_UPDATE => ProcVehicleListener, T::WEATHER_CHANGE => ProcWeatherListener,
      T::LIGHTNING_STRIKE => ProcWeatherListener, T::THUNDER_CHANGE => ProcWeatherListener
    }

    EVENT_NAME_TO_TYPE = {
      :block_break => T::BLOCK_BREAK, # block destroyed by player
      :block_burn => T::BLOCK_BURN, # block destroyed from burning
      :block_canbuild => T::BLOCK_CANBUILD, # can you build on this?
      :block_damage => T::BLOCK_DAMAGE, # player hits a block
      :block_fromto => T::BLOCK_FROMTO, # lava/water trying to move
      :block_ignite => T::BLOCK_IGNITE, # block being lit on fire
      :block_physics => T::BLOCK_PHYSICS, # physics check (adj. block cha)
      :block_place => T::BLOCK_PLACE, # player placing block
      :leaves_decay => T::LEAVES_DECAY, # natural leaf decay
      :player_animation => T::PLAYER_ANIMATION, # e.g. arm swinging
      :player_bucket_empty => T::PLAYER_BUCKET_EMPTY, # empties a bucket
      :player_bucket_fill => T::PLAYER_BUCKET_FILL, # fills a bucket
      :player_chat => T::PLAYER_CHAT, # player sends a chat message.
      :player_command_preprocess => T::PLAYER_COMMAND_PREPROCESS, #cmd
      :player_drop_item => T::PLAYER_DROP_ITEM, # player drops an item
      :player_egg_throw => T::PLAYER_EGG_THROW, # player throws an egg
      :player_interact => T::PLAYER_INTERACT, # player uses an item
      :player_inventory => T::PLAYER_INVENTORY, # player's inventory chang
      :player_item_held => T::PLAYER_ITEM_HELD, # player changes held item
      :player_join => T::PLAYER_JOIN, # a player enters the world
      :player_kick => T::PLAYER_KICK, # players been booted
      :player_login => T::PLAYER_LOGIN, # attempt to connect to the server
      :player_move => T::PLAYER_MOVE, # player moves in the world
      :player_pickup_item => T::PLAYER_PICKUP_ITEM, # player picks up item
      :player_quit => T::PLAYER_QUIT, # player leaves a server.
      :player_respawn => T::PLAYER_RESPAWN, # a player respawns
      :player_teleport => T::PLAYER_TELEPORT, # a player teleports
      :player_toggle_sneak => T::PLAYER_TOGGLE_SNEAK, # sneak mode toggled
      :redstone_change => T::REDSTONE_CHANGE, # redstone current change
      :sign_change => T::SIGN_CHANGE, # A sign has changed
      :inventory_open => T::INVENTORY_OPEN, # opens inventory
      :inventory_close => T::INVENTORY_CLOSE, # closes inventory
      :inventory_click => T::INVENTORY_CLICK, # clicks inventory slot
      :inventory_change => T::INVENTORY_CHANGE, # inventory slot change
      :inventory_transaction => T::INVENTORY_TRANSACTION, # trying
      :plugin_enable => T::PLUGIN_ENABLE, # plugin has been enabled
      :plugin_disable => T::PLUGIN_DISABLE, # plugin has been disabled
      :sever_command => T::SERVER_COMMAND, # server command issued
      :chunk_load => T::CHUNK_LOAD, # Chunk of world loaded
      :chunk_unload => T::CHUNK_UNLOAD, # Chunk of world unloaded
      :chunk_generation => T::CHUNK_GENERATION, # Chunk of world generatin
      :item_spawn => T::ITEM_SPAWN, # item spawns in world
      :spawn_change => T::SPAWN_CHANGE, # spawn changed in some way
      :world_save => T::WORLD_SAVE, # world is being saved
      :world_load => T::WORLD_LOAD, # world is being loaded
      :creature_spawn => T::CREATURE_SPAWN, # mob/ani being created
      :entity_damage => T::ENTITY_DAMAGE, # living damaged from no source
      :entity_death => T::ENTITY_DEATH, # living thing dies
      :entity_combust => T::ENTITY_COMBUST, # catch fire (from sun)
      :entity_explode => T::ENTITY_EXPLODE, # TNT, Creeper, fireball
      :entity_explosion => T::EXPLOSION_PRIME, # Creeper decides to
      :entity_target => T::ENTITY_TARGET, # one entity targets another
      :entity_interact => T::ENTITY_INTERACT, # non-player inter w/ block
      :vehicle_create => T::VEHICLE_CREATE, # placed a vehicle
      :vehicle_destroy => T::VEHICLE_DESTROY, # destroyed a vehicle
      :vehicle_damage => T::VEHICLE_DAMAGE, # vehicle took damage
      :vehicle_collision_entity => T::VEHICLE_COLLISION_ENTITY, # col. entity
      :vehicle_collision_block => T::VEHICLE_COLLISION_BLOCK, # col. block
      :vehicle_enter => T::VEHICLE_ENTER, # entity enters vehicle
      :vehicle_exit => T::VEHICLE_EXIT, # entity exits vehicle
      :vehicle_move => T::VEHICLE_MOVE, # vehicle moves
      :vehicle_update => T::VEHICLE_UPDATE, # update cycle happening
      :custom_event => T::CUSTOM_EVENT, # not used
      :lightning_strike => T::LIGHTNING_STRIKE, # Lightning strikes something
      :weather_change => T::WEATHER_CHANGE, # Weather in the world changes
      :thunder_change => T::THUNDER_CHANGE # Thunder state has changed
    }

    def event(event_name, priority_value=:lowest, &code)
      type = event_type_for(event_name)
      priority = priority_for(priority_value)
      listener = listener_for(type).new(&code)
      plugin_manager.register_event(type, listener, priority, @plugin)
    end

    def event_type_for(name)
      EVENT_NAME_TO_TYPE[name.to_sym]
    end
    private :event_type_for

    def priority_for(value)
      case value
      when :lowest then BukkitEvent::Priority::Lowest
      when :low then BukkitEvent::Priority::Low
      when :normal then BukkitEvent::Priority::Normal
      when :high then BukkitEvent::Priority::High
      when :highest then BukkitEvent::Priority::Highest
      when :monitor then BukkitEvent::Priority::Monitor
      end
    end
    private :priority_for

    def listener_for(event_type)
      EVENT_TO_LISTENER[event_type]
    end
    private :listener_for
  end

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
    end
  end

  class Purugin
    include ::Purugin::Base
    
    def on_load
      plugin_manager.load_plugins java.io.File.new("plugins")
    end

    def on_enable
      $plugins.each { |plugin| plugin_manager.enable_plugin plugin }
    end

    def on_disable
      $plugins.each { |plugin| plugin_manager.disable_plugin plugin }
    end
    
    def getDescription
      @plugin.get_description
    end
    
    def getConfiguration
      @plugin.get_configuration
    end
    
    def instantiate_plugin(plugin_loader, path)
      return unless $last_loaded
      plugin = $last_loaded.new(@plugin, plugin_loader, path)
      $last_loaded = nil;
      plugin
    end
  end
end

class Object
  def purugin(name, version, &code)
    cls = Class.new do
      include Purugin::Plugin
      description name, version      
    end
    cls.class_eval &code    
  end
end

Purugin::Purugin