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
    
    class ProcInventoryListener < org.bukkit.event.inventory.InventoryListener
      include ProcLogic
      handlers :onFurnaceBurn, :onFurnaceSmelt
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

    def event(event_name, priority_value=:lowest, &code)
      type = event_type_for(event_name)
      priority = priority_for(priority_value)
      listener = listener_for(type).new(&code)
      plugin_manager.register_event(type, listener, priority, self)
    end
    alias on event

    def event_type_for(name)
      name = name.to_s.upcase
      T.values.find { |event| event.name == name }
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
      case event_type.category
      when BukkitEvent::Category::PLAYER then ProcPlayerListener
      when BukkitEvent::Category::ENTITY then ProcEntityListener
      when BukkitEvent::Category::BLOCK then ProcBlockListener
      when BukkitEvent::Category::LIVING_ENTITY then ProcEntityListener
      when BukkitEvent::Category::WEATHER then ProcWeatherListener
      when BukkitEvent::Category::VEHICLE then ProcVehicleListener
      when BukkitEvent::Category::WORLD then ProcWorldListener
      when BukkitEvent::Category::SERVER then ProcServerListener
      when BukkitEvent::Category::INVENTORY then ProcInventoryListener
      when BukkitEvent::Category::MISCELLANEOUS then ProcCustomListener
      end
    end
    private :listener_for
  end
end
