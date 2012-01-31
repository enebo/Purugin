require 'java'
require 'purugin/predicate'

class org::bukkit::event::player::PlayerPreLoginEvent
  extend Purugin::Predicate

  # Will define predicates for all states of login events: result.allowed?, result.kick_other?, etc...
  enum_predicates org.bukkit.event.player.PlayerPreLoginEvent::Result
end

