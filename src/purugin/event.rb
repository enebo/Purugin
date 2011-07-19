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
end
