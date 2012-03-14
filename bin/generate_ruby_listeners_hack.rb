require 'src/purugin/util'

include Purugin::StringUtils

# Quick hack on results of searching Bukkit:
# % find . -name '*.java' | xargs grep 'Event extends' > aaa
# % cat aaa | ruby -ne 'a ||= [] ; a << split(/:/)[1].gsub(/(public|class|abstract)\s+/, "").split(/ extends.*/)[0].inspect; END { puts  a.join(", ") }'
EVENT_CLASS_NAMES = ["BlockBreakEvent", "BlockBurnEvent", "BlockCanBuildEvent", "BlockDamageEvent", 
  "BlockDispenseEvent", "BlockEvent", "BlockFadeEvent", "BlockFormEvent", "BlockFromToEvent", 
  "BlockGrowEvent", "BlockIgniteEvent", "BlockPhysicsEvent", "BlockPistonEvent", 
  "BlockPistonExtendEvent", "BlockPistonRetractEvent", "BlockPlaceEvent", "BlockRedstoneEvent",
  "BlockSpreadEvent", "EntityBlockFormEvent", "LeavesDecayEvent", "SignChangeEvent",
  "EnchantItemEvent", "PrepareItemEnchantEvent", "CreatureSpawnEvent", "CreeperPowerEvent",
  "EntityChangeBlockEvent", "EntityCombustByBlockEvent", "EntityCombustByEntityEvent",
  "EntityCombustEvent", "EntityCreatePortalEvent", "EntityDamageByBlockEvent",
  "EntityDamageByEntityEvent", "EntityDamageEvent", "EntityDeathEvent", "EntityEvent",
  "EntityExplodeEvent", "EntityInteractEvent", "EntityPortalEnterEvent", "EntityRegainHealthEvent",
  "EntityShootBowEvent", "EntityTameEvent", "EntityTargetEvent", "EntityTeleportEvent",
  "ExplosionPrimeEvent", "FoodLevelChangeEvent", "ItemDespawnEvent", "ItemSpawnEvent",
  "PigZapEvent", "PlayerDeathEvent", "PotionSplashEvent", "ProjectileHitEvent", "SheepDyeWoolEvent",
  "SheepRegrowWoolEvent", "SlimeSplitEvent", "BrewEvent", "CraftItemEvent", "FurnaceBurnEvent",
  "FurnaceSmeltEvent", "InventoryClickEvent", "InventoryCloseEvent", "InventoryEvent",
  "InventoryOpenEvent", "PrepareItemCraftEvent", "PaintingBreakByEntityEvent", "PaintingBreakEvent",
  "PaintingEvent", "PaintingPlaceEvent", "PlayerAnimationEvent", "PlayerBedEnterEvent",
  "PlayerBedLeaveEvent", "PlayerBucketEmptyEvent", "PlayerBucketEvent", "PlayerBucketFillEvent",
  "PlayerChangedWorldEvent", "PlayerChatEvent", "PlayerCommandPreprocessEvent",
  "PlayerDropItemEvent", "PlayerEggThrowEvent", "PlayerEvent", "PlayerExpChangeEvent",
  "PlayerFishEvent", "PlayerGameModeChangeEvent", "PlayerInteractEntityEvent",
  "PlayerInteractEvent", "PlayerInventoryEvent", "PlayerItemHeldEvent", "PlayerJoinEvent",
  "PlayerKickEvent", "PlayerLevelChangeEvent", "PlayerLoginEvent", "PlayerMoveEvent",
  "PlayerPickupItemEvent", "PlayerPortalEvent", "PlayerPreLoginEvent", "PlayerQuitEvent",
  "PlayerRespawnEvent", "PlayerShearEntityEvent", "PlayerTeleportEvent", "PlayerToggleSneakEvent",
  "PlayerToggleSprintEvent", "PlayerVelocityEvent", "MapInitializeEvent", "PluginDisableEvent",
  "PluginEnableEvent", "PluginEvent", "RemoteServerCommandEvent", "ServerCommandEvent",
  "ServerEvent", "ServerListPingEvent", "ServiceEvent", "ServiceRegisterEvent",
  "ServiceUnregisterEvent", "VehicleBlockCollisionEvent", "VehicleCollisionEvent",
  "VehicleCreateEvent", "VehicleDamageEvent", "VehicleDestroyEvent", "VehicleEnterEvent",
  "VehicleEntityCollisionEvent", "VehicleEvent", "VehicleExitEvent", "VehicleMoveEvent",
  "VehicleUpdateEvent", "LightningStrikeEvent", "ThunderChangeEvent", "WeatherChangeEvent",
  "WeatherEvent", "ChunkEvent", "ChunkLoadEvent", "ChunkPopulateEvent", "ChunkUnloadEvent",
  "PortalCreateEvent", "SpawnChangeEvent", "StructureGrowEvent", "WorldEvent", "WorldInitEvent",
  "WorldLoadEvent", "WorldSaveEvent", "WorldUnloadEvent"]

listener_names = EVENT_CLASS_NAMES.dup

listener_names.map! { |name| "#{name}Listener" }

BUKKIT_SRC_DIR='../bukkit/src/main/java'
FOUND = {}
require 'find'
Dir.chdir(BUKKIT_SRC_DIR) do
  Find::find(".") do |path|
    EVENT_CLASS_NAMES.each do |name|
      if path.end_with? name + ".java"
        FOUND[name] = path.gsub(/\//, '.').sub('..', '').sub(/.java$/, '')
      end
    end
  end
end

# To be put into src/purugin/event.rb
EVENT_CLASS_NAMES.each_with_index do |event, i|
  puts <<-EOS
    class #{listener_names[i]}
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, #{FOUND[event]}]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

  EOS
end

puts "    EVENT_NAME_TO_LISTENER = {"
EVENT_CLASS_NAMES.each_with_index do |event, i|
  puts "      :#{camelcase_to(event.sub(/Event$/, ''), '_').downcase} => #{listener_names[i]},"
end
puts "    }"