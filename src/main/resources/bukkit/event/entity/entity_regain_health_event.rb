require 'java'
require 'purugin/predicate'

class org::bukkit::event::entity::EntityRegainHealthEvent
  extend Purugin::Predicate

  # Will define predicates for all Regain Health events: regain_reason.regen?,
  # regain_reason.eating?, etc...
  enum_predicates org.bukkit.event.entity.EntityRegainHealthEvent::RegainReason
end
