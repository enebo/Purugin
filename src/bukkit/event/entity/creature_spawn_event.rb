require 'java'
require 'purugin/predicate'

class org::bukkit::event::entity::CreatureSpawnEvent
  extend Purugin::Predicate
  
  # Will define predicates for all Creature Spawns: cause.egg?, cause.spawner?, etc...
  enum_predicates org.bukkit.event.entity.CreatureSpawnEvent::SpawnReason
end