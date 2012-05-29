require 'java'
require 'purugin/predicate'

class org::bukkit::event::entity::EntityTargetEvent
  extend Purugin::Predicate

  # Will define predicates for all Target events: reason.target_died?, reason.random_target?, etc...
  enum_predicates org.bukkit.event.entity.EntityTargetEvent::TargetReason
end

