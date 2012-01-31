require 'java'
require 'purugin/predicate'

class org::bukkit::event::entity::EntityDamageEvent
  extend Purugin::Predicate
  
  # Will define predicates for all DamageCauses: cause.contact?, cause.drowning?, cause.lava?, etc...
  enum_predicates org.bukkit.event.entity.EntityDamageEvent::DamageCause
end