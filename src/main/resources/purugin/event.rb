require 'java'

module Purugin
  module Event
    # FIXME: This only handles normal priority.  Real fix is to generate these on demand versus up
    # front.  We can reify what we need.  This will also fix custom event types.

    require 'jruby/core_ext'

    # These listeners and the map below come from auto-generation via generate_ruby_listeners_hack    
    class BlockBreakEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.block.BlockBreakEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class BlockBurnEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.block.BlockBurnEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class BlockCanBuildEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.block.BlockCanBuildEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class BlockDamageEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.block.BlockDamageEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class BlockDispenseEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.block.BlockDispenseEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class BlockEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.block.BlockEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class BlockFadeEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.block.BlockFadeEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class BlockFormEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.block.BlockFormEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class BlockFromToEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.block.BlockFromToEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class BlockGrowEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.block.BlockGrowEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class BlockIgniteEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.block.BlockIgniteEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class BlockPhysicsEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.block.BlockPhysicsEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class BlockPistonEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.block.BlockPistonEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class BlockPistonExtendEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.block.BlockPistonExtendEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class BlockPistonRetractEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.block.BlockPistonRetractEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class BlockPlaceEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.block.BlockPlaceEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class BlockRedstoneEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.block.BlockRedstoneEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class BlockSpreadEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.block.BlockSpreadEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class EntityBlockFormEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.block.EntityBlockFormEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class LeavesDecayEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.block.LeavesDecayEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class SignChangeEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.block.SignChangeEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class EnchantItemEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.enchantment.EnchantItemEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PrepareItemEnchantEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.enchantment.PrepareItemEnchantEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class CreatureSpawnEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.entity.CreatureSpawnEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class CreeperPowerEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.entity.CreeperPowerEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class EntityChangeBlockEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.entity.EntityChangeBlockEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class EntityCombustByBlockEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.entity.EntityCombustByBlockEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class EntityCombustByEntityEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.entity.EntityCombustByEntityEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class EntityCombustEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.entity.EntityCombustEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class EntityCreatePortalEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.entity.EntityCreatePortalEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class EntityDamageByBlockEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.entity.EntityDamageByBlockEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class EntityDamageByEntityEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.entity.EntityDamageByEntityEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class EntityDamageEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.entity.EntityDamageEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class EntityDeathEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.entity.EntityDeathEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class EntityEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.entity.EntityCombustByEntityEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class EntityExplodeEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.entity.EntityExplodeEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class EntityInteractEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.entity.EntityInteractEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class EntityPortalEnterEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.entity.EntityPortalEnterEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class EntityRegainHealthEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.entity.EntityRegainHealthEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class EntityShootBowEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.entity.EntityShootBowEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class EntityTameEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.entity.EntityTameEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class EntityTargetEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.entity.EntityTargetEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class EntityTeleportEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.entity.EntityTeleportEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class ExplosionPrimeEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.entity.ExplosionPrimeEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class FoodLevelChangeEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.entity.FoodLevelChangeEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class ItemDespawnEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.entity.ItemDespawnEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class ItemSpawnEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.entity.ItemSpawnEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PigZapEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.entity.PigZapEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PlayerDeathEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.entity.PlayerDeathEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PotionSplashEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.entity.PotionSplashEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class ProjectileHitEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.entity.ProjectileHitEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class SheepDyeWoolEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.entity.SheepDyeWoolEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class SheepRegrowWoolEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.entity.SheepRegrowWoolEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class SlimeSplitEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.entity.SlimeSplitEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class BrewEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.inventory.BrewEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class CraftItemEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.inventory.CraftItemEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class FurnaceBurnEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.inventory.FurnaceBurnEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class FurnaceSmeltEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.inventory.FurnaceSmeltEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class InventoryClickEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.inventory.InventoryClickEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class InventoryCloseEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.inventory.InventoryCloseEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class InventoryEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.inventory.InventoryEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class InventoryOpenEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.inventory.InventoryOpenEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PrepareItemCraftEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.inventory.PrepareItemCraftEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PaintingBreakByEntityEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.painting.PaintingBreakByEntityEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PaintingBreakEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.painting.PaintingBreakEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PaintingEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.painting.PaintingEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PaintingPlaceEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.painting.PaintingPlaceEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PlayerAnimationEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.player.PlayerAnimationEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PlayerBedEnterEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.player.PlayerBedEnterEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PlayerBedLeaveEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.player.PlayerBedLeaveEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PlayerBucketEmptyEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.player.PlayerBucketEmptyEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PlayerBucketEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.player.PlayerBucketEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PlayerBucketFillEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.player.PlayerBucketFillEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PlayerChangedWorldEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.player.PlayerChangedWorldEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PlayerChatEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.player.PlayerChatEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PlayerCommandPreprocessEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.player.PlayerCommandPreprocessEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PlayerDropItemEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.player.PlayerDropItemEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PlayerEggThrowEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.player.PlayerEggThrowEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PlayerEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.player.PlayerEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PlayerExpChangeEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.player.PlayerExpChangeEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PlayerFishEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.player.PlayerFishEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PlayerGameModeChangeEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.player.PlayerGameModeChangeEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PlayerInteractEntityEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.player.PlayerInteractEntityEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PlayerInteractEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.player.PlayerInteractEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PlayerInventoryEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.player.PlayerInventoryEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PlayerItemHeldEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.player.PlayerItemHeldEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PlayerJoinEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.player.PlayerJoinEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PlayerKickEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.player.PlayerKickEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PlayerLevelChangeEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.player.PlayerLevelChangeEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PlayerLoginEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.player.PlayerLoginEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PlayerMoveEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.player.PlayerMoveEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PlayerPickupItemEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.player.PlayerPickupItemEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PlayerPortalEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.player.PlayerPortalEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PlayerPreLoginEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.player.PlayerPreLoginEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PlayerQuitEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.player.PlayerQuitEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PlayerRespawnEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.player.PlayerRespawnEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PlayerShearEntityEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.player.PlayerShearEntityEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PlayerTeleportEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.player.PlayerTeleportEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PlayerToggleSneakEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.player.PlayerToggleSneakEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PlayerToggleSprintEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.player.PlayerToggleSprintEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PlayerVelocityEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.player.PlayerVelocityEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class MapInitializeEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.server.MapInitializeEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PluginDisableEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.server.PluginDisableEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PluginEnableEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.server.PluginEnableEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PluginEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.server.PluginEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class RemoteServerCommandEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.server.RemoteServerCommandEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class ServerCommandEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.server.RemoteServerCommandEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class ServerEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.server.ServerEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class ServerListPingEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.server.ServerListPingEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class ServiceEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.server.ServiceEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class ServiceRegisterEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.server.ServiceRegisterEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class ServiceUnregisterEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.server.ServiceUnregisterEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class VehicleBlockCollisionEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.vehicle.VehicleBlockCollisionEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class VehicleCollisionEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.vehicle.VehicleCollisionEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class VehicleCreateEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.vehicle.VehicleCreateEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class VehicleDamageEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.vehicle.VehicleDamageEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class VehicleDestroyEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.vehicle.VehicleDestroyEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class VehicleEnterEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.vehicle.VehicleEnterEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class VehicleEntityCollisionEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.vehicle.VehicleEntityCollisionEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class VehicleEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.vehicle.VehicleEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class VehicleExitEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.vehicle.VehicleExitEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class VehicleMoveEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.vehicle.VehicleMoveEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class VehicleUpdateEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.vehicle.VehicleUpdateEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class LightningStrikeEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.weather.LightningStrikeEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class ThunderChangeEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.weather.ThunderChangeEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class WeatherChangeEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.weather.WeatherChangeEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class WeatherEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.weather.WeatherEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class ChunkEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.world.ChunkEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class ChunkLoadEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.world.ChunkLoadEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class ChunkPopulateEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.world.ChunkPopulateEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class ChunkUnloadEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.world.ChunkUnloadEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class PortalCreateEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.world.PortalCreateEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class SpawnChangeEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.world.SpawnChangeEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class StructureGrowEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.world.StructureGrowEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class WorldEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.player.PlayerChangedWorldEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class WorldInitEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.world.WorldInitEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class WorldLoadEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.world.WorldLoadEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class WorldSaveEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.world.WorldSaveEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    class WorldUnloadEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.world.WorldUnloadEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end

    EVENT_NAME_TO_LISTENER = {
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
      :entity_block_form => EntityBlockFormEventListener,
      :leaves_decay => LeavesDecayEventListener,
      :sign_change => SignChangeEventListener,
      :enchant_item => EnchantItemEventListener,
      :prepare_item_enchant => PrepareItemEnchantEventListener,
      :creature_spawn => CreatureSpawnEventListener,
      :creeper_power => CreeperPowerEventListener,
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
      :entity_teleport => EntityTeleportEventListener,
      :explosion_prime => ExplosionPrimeEventListener,
      :food_level_change => FoodLevelChangeEventListener,
      :item_despawn => ItemDespawnEventListener,
      :item_spawn => ItemSpawnEventListener,
      :pig_zap => PigZapEventListener,
      :player_death => PlayerDeathEventListener,
      :potion_splash => PotionSplashEventListener,
      :projectile_hit => ProjectileHitEventListener,
      :sheep_dye_wool => SheepDyeWoolEventListener,
      :sheep_regrow_wool => SheepRegrowWoolEventListener,
      :slime_split => SlimeSplitEventListener,
      :brew => BrewEventListener,
      :craft_item => CraftItemEventListener,
      :furnace_burn => FurnaceBurnEventListener,
      :furnace_smelt => FurnaceSmeltEventListener,
      :inventory_click => InventoryClickEventListener,
      :inventory_close => InventoryCloseEventListener,
      :inventory => InventoryEventListener,
      :inventory_open => InventoryOpenEventListener,
      :prepare_item_craft => PrepareItemCraftEventListener,
      :painting_break_by_entity => PaintingBreakByEntityEventListener,
      :painting_break => PaintingBreakEventListener,
      :painting => PaintingEventListener,
      :painting_place => PaintingPlaceEventListener,
      :player_animation => PlayerAnimationEventListener,
      :player_bed_enter => PlayerBedEnterEventListener,
      :player_bed_leave => PlayerBedLeaveEventListener,
      :player_bucket_empty => PlayerBucketEmptyEventListener,
      :player_bucket => PlayerBucketEventListener,
      :player_bucket_fill => PlayerBucketFillEventListener,
      :player_changed_world => PlayerChangedWorldEventListener,
      :player_chat => PlayerChatEventListener,
      :player_command_preprocess => PlayerCommandPreprocessEventListener,
      :player_drop_item => PlayerDropItemEventListener,
      :player_egg_throw => PlayerEggThrowEventListener,
      :player => PlayerEventListener,
      :player_exp_change => PlayerExpChangeEventListener,
      :player_fish => PlayerFishEventListener,
      :player_game_mode_change => PlayerGameModeChangeEventListener,
      :player_interact_entity => PlayerInteractEntityEventListener,
      :player_interact => PlayerInteractEventListener,
      :player_inventory => PlayerInventoryEventListener,
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
      :player_respawn => PlayerRespawnEventListener,
      :player_shear_entity => PlayerShearEntityEventListener,
      :player_teleport => PlayerTeleportEventListener,
      :player_toggle_sneak => PlayerToggleSneakEventListener,
      :player_toggle_sprint => PlayerToggleSprintEventListener,
      :player_velocity => PlayerVelocityEventListener,
      :map_initialize => MapInitializeEventListener,
      :plugin_disable => PluginDisableEventListener,
      :plugin_enable => PluginEnableEventListener,
      :plugin => PluginEventListener,
      :remote_server_command => RemoteServerCommandEventListener,
      :server_command => ServerCommandEventListener,
      :server => ServerEventListener,
      :server_list_ping => ServerListPingEventListener,
      :service => ServiceEventListener,
      :service_register => ServiceRegisterEventListener,
      :service_unregister => ServiceUnregisterEventListener,
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
      :lightning_strike => LightningStrikeEventListener,
      :thunder_change => ThunderChangeEventListener,
      :weather_change => WeatherChangeEventListener,
      :weather => WeatherEventListener,
      :chunk => ChunkEventListener,
      :chunk_load => ChunkLoadEventListener,
      :chunk_populate => ChunkPopulateEventListener,
      :chunk_unload => ChunkUnloadEventListener,
      :portal_create => PortalCreateEventListener,
      :spawn_change => SpawnChangeEventListener,
      :structure_grow => StructureGrowEventListener,
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