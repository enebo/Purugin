require 'java'

module Purugin
  module EventDefiner
    def define_event_listener(name, package)
      self.module_eval <<-EOS
        class #{name}Listener
          include org.bukkit.event.Listener
          def initialize(&code); @code = code; end
          def on_event(event); @code.call(event); end
          add_method_signature 'on_event', [java.lang.Void::TYPE, #{package}.#{name}]
          add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
          become_java!
        end      
      EOS
    end    
  end
  module Event
    # FIXME: This only handles normal priority.  Real fix is to generate these on demand versus up
    # front.  We can reify what we need.  This will also fix custom event types.

    require 'jruby/core_ext'
    
    extend Purugin::EventDefiner
    
    # These listeners and the map below come from auto-generation via generate_ruby_listeners_hack    
     define_event_listener('AsyncPlayerChatEvent', 'org.bukkit.event.player')
    define_event_listener('AsyncPlayerPreLoginEvent', 'org.bukkit.event.player')
    define_event_listener('BlockBreakEvent', 'org.bukkit.event.block')
    define_event_listener('BlockBurnEvent', 'org.bukkit.event.block')
    define_event_listener('BlockCanBuildEvent', 'org.bukkit.event.block')
    define_event_listener('BlockDamageEvent', 'org.bukkit.event.block')
    define_event_listener('BlockDispenseEvent', 'org.bukkit.event.block')
    define_event_listener('BlockEvent', 'org.bukkit.event.block')
    define_event_listener('BlockFadeEvent', 'org.bukkit.event.block')
    define_event_listener('BlockFormEvent', 'org.bukkit.event.block')
    define_event_listener('BlockFromToEvent', 'org.bukkit.event.block')
    define_event_listener('BlockGrowEvent', 'org.bukkit.event.block')
    define_event_listener('BlockIgniteEvent', 'org.bukkit.event.block')
    define_event_listener('BlockPhysicsEvent', 'org.bukkit.event.block')
    define_event_listener('BlockPistonEvent', 'org.bukkit.event.block')
    define_event_listener('BlockPistonExtendEvent', 'org.bukkit.event.block')
    define_event_listener('BlockPistonRetractEvent', 'org.bukkit.event.block')
    define_event_listener('BlockPlaceEvent', 'org.bukkit.event.block')
    define_event_listener('BlockRedstoneEvent', 'org.bukkit.event.block')
    define_event_listener('BlockSpreadEvent', 'org.bukkit.event.block')
    define_event_listener('BrewEvent', 'org.bukkit.event.inventory')
    define_event_listener('ChunkEvent', 'org.bukkit.event.world')
    define_event_listener('ChunkLoadEvent', 'org.bukkit.event.world')
    define_event_listener('ChunkPopulateEvent', 'org.bukkit.event.world')
    define_event_listener('ChunkUnloadEvent', 'org.bukkit.event.world')
    define_event_listener('ConversationAbandonedEvent', 'org.bukkit.conversations')
    define_event_listener('CraftItemEvent', 'org.bukkit.event.inventory')
    define_event_listener('CreatureSpawnEvent', 'org.bukkit.event.entity')
    define_event_listener('CreeperPowerEvent', 'org.bukkit.event.entity')
    define_event_listener('EnchantItemEvent', 'org.bukkit.event.enchantment')
    define_event_listener('EntityBlockFormEvent', 'org.bukkit.event.block')
    define_event_listener('EntityBreakDoorEvent', 'org.bukkit.event.entity')
    define_event_listener('EntityChangeBlockEvent', 'org.bukkit.event.entity')
    define_event_listener('EntityCombustByBlockEvent', 'org.bukkit.event.entity')
    define_event_listener('EntityCombustByEntityEvent', 'org.bukkit.event.entity')
    define_event_listener('EntityCombustEvent', 'org.bukkit.event.entity')
    define_event_listener('EntityCreatePortalEvent', 'org.bukkit.event.entity')
    define_event_listener('EntityDamageByBlockEvent', 'org.bukkit.event.entity')
    define_event_listener('EntityDamageByEntityEvent', 'org.bukkit.event.entity')
    define_event_listener('EntityDamageEvent', 'org.bukkit.event.entity')
    define_event_listener('EntityDeathEvent', 'org.bukkit.event.entity')
    define_event_listener('EntityEvent', 'org.bukkit.event.entity')
    define_event_listener('EntityExplodeEvent', 'org.bukkit.event.entity')
    define_event_listener('EntityInteractEvent', 'org.bukkit.event.entity')
    define_event_listener('EntityPortalEnterEvent', 'org.bukkit.event.entity')
    define_event_listener('EntityRegainHealthEvent', 'org.bukkit.event.entity')
    define_event_listener('EntityShootBowEvent', 'org.bukkit.event.entity')
    define_event_listener('EntityTameEvent', 'org.bukkit.event.entity')
    define_event_listener('EntityTargetEvent', 'org.bukkit.event.entity')
    define_event_listener('EntityTargetLivingEntityEvent', 'org.bukkit.event.entity')
    define_event_listener('EntityTeleportEvent', 'org.bukkit.event.entity')
    define_event_listener('ExpBottleEvent', 'org.bukkit.event.entity')
    define_event_listener('ExplosionPrimeEvent', 'org.bukkit.event.entity')
    define_event_listener('FoodLevelChangeEvent', 'org.bukkit.event.entity')
    define_event_listener('FurnaceBurnEvent', 'org.bukkit.event.inventory')
    define_event_listener('FurnaceSmeltEvent', 'org.bukkit.event.inventory')
    define_event_listener('InventoryClickEvent', 'org.bukkit.event.inventory')
    define_event_listener('InventoryCloseEvent', 'org.bukkit.event.inventory')
    define_event_listener('InventoryEvent', 'org.bukkit.event.inventory')
    define_event_listener('InventoryOpenEvent', 'org.bukkit.event.inventory')
    define_event_listener('ItemDespawnEvent', 'org.bukkit.event.entity')
    define_event_listener('ItemSpawnEvent', 'org.bukkit.event.entity')
    define_event_listener('LeavesDecayEvent', 'org.bukkit.event.block')
    define_event_listener('LightningStrikeEvent', 'org.bukkit.event.weather')
    define_event_listener('MapInitializeEvent', 'org.bukkit.event.server')
    define_event_listener('NotePlayEvent', 'org.bukkit.event.block')
    define_event_listener('PaintingBreakByEntityEvent', 'org.bukkit.event.painting')
    define_event_listener('PaintingBreakEvent', 'org.bukkit.event.painting')
    define_event_listener('PaintingEvent', 'org.bukkit.event.painting')
    define_event_listener('PaintingPlaceEvent', 'org.bukkit.event.painting')
    define_event_listener('PigZapEvent', 'org.bukkit.event.entity')
    define_event_listener('PlayerAnimationEvent', 'org.bukkit.event.player')
    define_event_listener('PlayerBedEnterEvent', 'org.bukkit.event.player')
    define_event_listener('PlayerBedLeaveEvent', 'org.bukkit.event.player')
    define_event_listener('PlayerBucketEmptyEvent', 'org.bukkit.event.player')
    define_event_listener('PlayerBucketEvent', 'org.bukkit.event.player')
    define_event_listener('PlayerBucketFillEvent', 'org.bukkit.event.player')
    define_event_listener('PlayerChangedWorldEvent', 'org.bukkit.event.player')
    define_event_listener('PlayerChannelEvent', 'org.bukkit.event.player')
    define_event_listener('PlayerChatEvent', 'org.bukkit.event.player')
    define_event_listener('PlayerChatTabCompleteEvent', 'org.bukkit.event.player')
    define_event_listener('PlayerCommandPreprocessEvent', 'org.bukkit.event.player')
    define_event_listener('PlayerDeathEvent', 'org.bukkit.event.entity')
    define_event_listener('PlayerDropItemEvent', 'org.bukkit.event.player')
    define_event_listener('PlayerEggThrowEvent', 'org.bukkit.event.player')
    define_event_listener('PlayerEvent', 'org.bukkit.event.player')
    define_event_listener('PlayerExpChangeEvent', 'org.bukkit.event.player')
    define_event_listener('PlayerFishEvent', 'org.bukkit.event.player')
    define_event_listener('PlayerGameModeChangeEvent', 'org.bukkit.event.player')
    define_event_listener('PlayerInteractEntityEvent', 'org.bukkit.event.player')
    define_event_listener('PlayerInteractEvent', 'org.bukkit.event.player')
    define_event_listener('PlayerInventoryEvent', 'org.bukkit.event.player')
    define_event_listener('PlayerItemBreakEvent', 'org.bukkit.event.player')
    define_event_listener('PlayerItemHeldEvent', 'org.bukkit.event.player')
    define_event_listener('PlayerJoinEvent', 'org.bukkit.event.player')
    define_event_listener('PlayerKickEvent', 'org.bukkit.event.player')
    define_event_listener('PlayerLevelChangeEvent', 'org.bukkit.event.player')
    define_event_listener('PlayerLoginEvent', 'org.bukkit.event.player')
    define_event_listener('PlayerMoveEvent', 'org.bukkit.event.player')
    define_event_listener('PlayerPickupItemEvent', 'org.bukkit.event.player')
    define_event_listener('PlayerPortalEvent', 'org.bukkit.event.player')
    define_event_listener('PlayerPreLoginEvent', 'org.bukkit.event.player')
    define_event_listener('PlayerQuitEvent', 'org.bukkit.event.player')
    define_event_listener('PlayerRegisterChannelEvent', 'org.bukkit.event.player')
    define_event_listener('PlayerRespawnEvent', 'org.bukkit.event.player')
    define_event_listener('PlayerShearEntityEvent', 'org.bukkit.event.player')
    define_event_listener('PlayerTeleportEvent', 'org.bukkit.event.player')
    define_event_listener('PlayerToggleFlightEvent', 'org.bukkit.event.player')
    define_event_listener('PlayerToggleSneakEvent', 'org.bukkit.event.player')
    define_event_listener('PlayerToggleSprintEvent', 'org.bukkit.event.player')
    define_event_listener('PlayerUnregisterChannelEvent', 'org.bukkit.event.player')
    define_event_listener('PlayerVelocityEvent', 'org.bukkit.event.player')
    define_event_listener('PluginDisableEvent', 'org.bukkit.event.server')
    define_event_listener('PluginEnableEvent', 'org.bukkit.event.server')
    define_event_listener('PluginEvent', 'org.bukkit.event.server')
    define_event_listener('PortalCreateEvent', 'org.bukkit.event.world')
    define_event_listener('PotionSplashEvent', 'org.bukkit.event.entity')
    define_event_listener('PrepareItemCraftEvent', 'org.bukkit.event.inventory')
    define_event_listener('PrepareItemEnchantEvent', 'org.bukkit.event.enchantment')
    define_event_listener('ProjectileHitEvent', 'org.bukkit.event.entity')
    define_event_listener('ProjectileLaunchEvent', 'org.bukkit.event.entity')
    define_event_listener('RemoteServerCommandEvent', 'org.bukkit.event.server')
    define_event_listener('ServerCommandEvent', 'org.bukkit.event.server')
    define_event_listener('ServerEvent', 'org.bukkit.event.server')
    define_event_listener('ServerListPingEvent', 'org.bukkit.event.server')
    define_event_listener('ServiceEvent', 'org.bukkit.event.server')
    define_event_listener('ServiceRegisterEvent', 'org.bukkit.event.server')
    define_event_listener('ServiceUnregisterEvent', 'org.bukkit.event.server')
    define_event_listener('SheepDyeWoolEvent', 'org.bukkit.event.entity')
    define_event_listener('SheepRegrowWoolEvent', 'org.bukkit.event.entity')
    define_event_listener('SignChangeEvent', 'org.bukkit.event.block')
    define_event_listener('SlimeSplitEvent', 'org.bukkit.event.entity')
    define_event_listener('SpawnChangeEvent', 'org.bukkit.event.world')
    define_event_listener('StructureGrowEvent', 'org.bukkit.event.world')
    define_event_listener('ThunderChangeEvent', 'org.bukkit.event.weather')
    define_event_listener('VehicleBlockCollisionEvent', 'org.bukkit.event.vehicle')
    define_event_listener('VehicleCollisionEvent', 'org.bukkit.event.vehicle')
    define_event_listener('VehicleCreateEvent', 'org.bukkit.event.vehicle')
    define_event_listener('VehicleDamageEvent', 'org.bukkit.event.vehicle')
    define_event_listener('VehicleDestroyEvent', 'org.bukkit.event.vehicle')
    define_event_listener('VehicleEnterEvent', 'org.bukkit.event.vehicle')
    define_event_listener('VehicleEntityCollisionEvent', 'org.bukkit.event.vehicle')
    define_event_listener('VehicleEvent', 'org.bukkit.event.vehicle')
    define_event_listener('VehicleExitEvent', 'org.bukkit.event.vehicle')
    define_event_listener('VehicleMoveEvent', 'org.bukkit.event.vehicle')
    define_event_listener('VehicleUpdateEvent', 'org.bukkit.event.vehicle')
    define_event_listener('WeatherChangeEvent', 'org.bukkit.event.weather')
    define_event_listener('WeatherEvent', 'org.bukkit.event.weather')
    define_event_listener('WorldEvent', 'org.bukkit.event.world')
    define_event_listener('WorldInitEvent', 'org.bukkit.event.world')
    define_event_listener('WorldLoadEvent', 'org.bukkit.event.world')
    define_event_listener('WorldSaveEvent', 'org.bukkit.event.world')
    define_event_listener('WorldUnloadEvent', 'org.bukkit.event.world')

    EVENT_NAME_TO_LISTENER = {
      :async_player_chat => AsyncPlayerChatEventListener,
      :async_player_pre_login => AsyncPlayerPreLoginEventListener,
      :block_break => BlockBreakEventListener,
      :block_burn => BlockBurnEventListener,
      :block_can_build => BlockCanBuildEventListener,
      :block_damage => BlockDamageEventListener,
      :block_dispense => BlockDispenseEventListener,
      :block => BlockEventListener,
      :block_fade => BlockFadeEventListener,
      :block_form => BlockFormEventListener,
      :block_from_to => BlockFromToEventListener,
      :block_grow => BlockGrowEventListener,
      :block_ignite => BlockIgniteEventListener,
      :block_physics => BlockPhysicsEventListener,
      :block_piston => BlockPistonEventListener,
      :block_piston_extend => BlockPistonExtendEventListener,
      :block_piston_retract => BlockPistonRetractEventListener,
      :block_place => BlockPlaceEventListener,
      :block_redstone => BlockRedstoneEventListener,
      :block_spread => BlockSpreadEventListener,
      :brew => BrewEventListener,
      :chunk => ChunkEventListener,
      :chunk_load => ChunkLoadEventListener,
      :chunk_populate => ChunkPopulateEventListener,
      :chunk_unload => ChunkUnloadEventListener,
      :conversation_abandoned => ConversationAbandonedEventListener,
      :craft_item => CraftItemEventListener,
      :creature_spawn => CreatureSpawnEventListener,
      :creeper_power => CreeperPowerEventListener,
      :enchant_item => EnchantItemEventListener,
      :entity_block_form => EntityBlockFormEventListener,
      :entity_break_door => EntityBreakDoorEventListener,
      :entity_change_block => EntityChangeBlockEventListener,
      :entity_combust_by_block => EntityCombustByBlockEventListener,
      :entity_combust_by_entity => EntityCombustByEntityEventListener,
      :entity_combust => EntityCombustEventListener,
      :entity_create_portal => EntityCreatePortalEventListener,
      :entity_damage_by_block => EntityDamageByBlockEventListener,
      :entity_damage_by_entity => EntityDamageByEntityEventListener,
      :entity_damage => EntityDamageEventListener,
      :entity_death => EntityDeathEventListener,
      :entity => EntityEventListener,
      :entity_explode => EntityExplodeEventListener,
      :entity_interact => EntityInteractEventListener,
      :entity_portal_enter => EntityPortalEnterEventListener,
      :entity_regain_health => EntityRegainHealthEventListener,
      :entity_shoot_bow => EntityShootBowEventListener,
      :entity_tame => EntityTameEventListener,
      :entity_target => EntityTargetEventListener,
      :entity_target_living_entity => EntityTargetLivingEntityEventListener,
      :entity_teleport => EntityTeleportEventListener,
      :exp_bottle => ExpBottleEventListener,
      :explosion_prime => ExplosionPrimeEventListener,
      :food_level_change => FoodLevelChangeEventListener,
      :furnace_burn => FurnaceBurnEventListener,
      :furnace_smelt => FurnaceSmeltEventListener,
      :inventory_click => InventoryClickEventListener,
      :inventory_close => InventoryCloseEventListener,
      :inventory => InventoryEventListener,
      :inventory_open => InventoryOpenEventListener,
      :item_despawn => ItemDespawnEventListener,
      :item_spawn => ItemSpawnEventListener,
      :leaves_decay => LeavesDecayEventListener,
      :lightning_strike => LightningStrikeEventListener,
      :map_initialize => MapInitializeEventListener,
      :note_play => NotePlayEventListener,
      :painting_break_by_entity => PaintingBreakByEntityEventListener,
      :painting_break => PaintingBreakEventListener,
      :painting => PaintingEventListener,
      :painting_place => PaintingPlaceEventListener,
      :pig_zap => PigZapEventListener,
      :player_animation => PlayerAnimationEventListener,
      :player_bed_enter => PlayerBedEnterEventListener,
      :player_bed_leave => PlayerBedLeaveEventListener,
      :player_bucket_empty => PlayerBucketEmptyEventListener,
      :player_bucket => PlayerBucketEventListener,
      :player_bucket_fill => PlayerBucketFillEventListener,
      :player_changed_world => PlayerChangedWorldEventListener,
      :player_channel => PlayerChannelEventListener,
      :player_chat => PlayerChatEventListener,
      :player_chat_tab_complete => PlayerChatTabCompleteEventListener,
      :player_command_preprocess => PlayerCommandPreprocessEventListener,
      :player_death => PlayerDeathEventListener,
      :player_drop_item => PlayerDropItemEventListener,
      :player_egg_throw => PlayerEggThrowEventListener,
      :player => PlayerEventListener,
      :player_exp_change => PlayerExpChangeEventListener,
      :player_fish => PlayerFishEventListener,
      :player_game_mode_change => PlayerGameModeChangeEventListener,
      :player_interact_entity => PlayerInteractEntityEventListener,
      :player_interact => PlayerInteractEventListener,
      :player_inventory => PlayerInventoryEventListener,
      :player_item_break => PlayerItemBreakEventListener,
      :player_item_held => PlayerItemHeldEventListener,
      :player_join => PlayerJoinEventListener,
      :player_kick => PlayerKickEventListener,
      :player_level_change => PlayerLevelChangeEventListener,
      :player_login => PlayerLoginEventListener,
      :player_move => PlayerMoveEventListener,
      :player_pickup_item => PlayerPickupItemEventListener,
      :player_portal => PlayerPortalEventListener,
      :player_pre_login => PlayerPreLoginEventListener,
      :player_quit => PlayerQuitEventListener,
      :player_register_channel => PlayerRegisterChannelEventListener,
      :player_respawn => PlayerRespawnEventListener,
      :player_shear_entity => PlayerShearEntityEventListener,
      :player_teleport => PlayerTeleportEventListener,
      :player_toggle_flight => PlayerToggleFlightEventListener,
      :player_toggle_sneak => PlayerToggleSneakEventListener,
      :player_toggle_sprint => PlayerToggleSprintEventListener,
      :player_unregister_channel => PlayerUnregisterChannelEventListener,
      :player_velocity => PlayerVelocityEventListener,
      :plugin_disable => PluginDisableEventListener,
      :plugin_enable => PluginEnableEventListener,
      :plugin => PluginEventListener,
      :portal_create => PortalCreateEventListener,
      :potion_splash => PotionSplashEventListener,
      :prepare_item_craft => PrepareItemCraftEventListener,
      :prepare_item_enchant => PrepareItemEnchantEventListener,
      :projectile_hit => ProjectileHitEventListener,
      :projectile_launch => ProjectileLaunchEventListener,
      :remote_server_command => RemoteServerCommandEventListener,
      :server_command => ServerCommandEventListener,
      :server => ServerEventListener,
      :server_list_ping => ServerListPingEventListener,
      :service => ServiceEventListener,
      :service_register => ServiceRegisterEventListener,
      :service_unregister => ServiceUnregisterEventListener,
      :sheep_dye_wool => SheepDyeWoolEventListener,
      :sheep_regrow_wool => SheepRegrowWoolEventListener,
      :sign_change => SignChangeEventListener,
      :slime_split => SlimeSplitEventListener,
      :spawn_change => SpawnChangeEventListener,
      :structure_grow => StructureGrowEventListener,
      :thunder_change => ThunderChangeEventListener,
      :vehicle_block_collision => VehicleBlockCollisionEventListener,
      :vehicle_collision => VehicleCollisionEventListener,
      :vehicle_create => VehicleCreateEventListener,
      :vehicle_damage => VehicleDamageEventListener,
      :vehicle_destroy => VehicleDestroyEventListener,
      :vehicle_enter => VehicleEnterEventListener,
      :vehicle_entity_collision => VehicleEntityCollisionEventListener,
      :vehicle => VehicleEventListener,
      :vehicle_exit => VehicleExitEventListener,
      :vehicle_move => VehicleMoveEventListener,
      :vehicle_update => VehicleUpdateEventListener,
      :weather_change => WeatherChangeEventListener,
      :weather => WeatherEventListener,
      :world => WorldEventListener,
      :world_init => WorldInitEventListener,
      :world_load => WorldLoadEventListener,
      :world_save => WorldSaveEventListener,
      :world_unload => WorldUnloadEventListener,
    }
    
    def event(event_name, priority_value=:lowest, &code)
      type = EVENT_NAME_TO_LISTENER[event_name.to_sym]

      raise ArgumentError.new "No suck event #{event_name}" unless type
        
      plugin_manager.register_events(type.new(&code), self)
    end
    alias on event
  end
end