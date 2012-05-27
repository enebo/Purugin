require 'java'
require 'purugin/predicate'

class org::bukkit::event::entity::CreeperPowerEvent
  extend Purugin::Predicate

  # Will define predicates for all Powering events: cause.lightning?, cause.set_on?, cause.set_off?
  enum_predicates org.bukkit.event.entity.CreeperPowerEvent::PowerCause
end