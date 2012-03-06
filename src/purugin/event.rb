module Purugin
  module Event
    CATEGORIES = {} # Category -> Listener
    
    P = org.bukkit.event.EventPriority
    PRIORITIES = {:lowest => P::LOWEST, :low => P::LOW, :normal => P::NORMAL, :high => P::HIGH,
      :highest => P::HIGHEST, :monitor => P::MONITOR
    }

    ##
    # Construct a class which has all _onFoo_ methods from the base *Java* class dispatch 
    # through the constructors provided proc.  Additionally associate the category to the 
    # particular listener class.
    def self.proc_listener(event_listener_base, *categories)
      cls = Class.new(event_listener_base) do 
        def initialize(&proc)
          super()
          @proc = proc
        end

        def onEvent(event)
          @proc.call(event)
        end 
        
        event_listener_base.java_class.java_instance_methods.map do |m|
          name = m.name.to_s
          alias_method name, :onEvent if name =~ /\Aon/ && name != "onEvent"
        end
      end
      
      categories.each { |category| CATEGORIES[category] = cls }
      cls
    end
    
    # FIXME: It appears events are more fine-grained now and this is using deprecated APIs
    C = org.bukkit.event.Event::Category
    ProcBlockListener = proc_listener(org.bukkit.event.block.BlockListener, C::BLOCK)
    ProcCustomEventListener = proc_listener(org.bukkit.event.CustomEventListener, C::MISCELLANEOUS)
    ProcEntityListener = proc_listener(org.bukkit.event.entity.EntityListener, C::ENTITY, C::LIVING_ENTITY)
    ProcInventoryListener = proc_listener(org.bukkit.event.inventory.InventoryListener, C::INVENTORY)
    ProcPlayerListener = proc_listener(org.bukkit.event.player.PlayerListener, C::PLAYER)
    ProcServerListener = proc_listener(org.bukkit.event.server.ServerListener, C::SERVER)
    ProcVehicleListener = proc_listener(org.bukkit.event.vehicle.VehicleListener, C::VEHICLE)
    ProcWeatherListener = proc_listener(org.bukkit.event.weather.WeatherListener, C::WEATHER)
    ProcWorldListener = proc_listener(org.bukkit.event.world.WorldListener, C::WORLD)

    def event(event_name, priority_value=:lowest, &code)
      type = event_type_for(event_name)
      priority = PRIORITIES[priority_value]
      listener = CATEGORIES[type.category].new(&code)
      plugin_manager.register_event(type, listener, priority, self)
    end
    alias on event

    def event_type_for(name)
      name = name.to_s.upcase
      org.bukkit.event.Event::Type.values.find { |event| event.name == name }
    end
    private :event_type_for
  end
end