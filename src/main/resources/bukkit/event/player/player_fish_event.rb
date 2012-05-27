require 'java'
require 'purugin/predicate'

class org::bukkit::event::player::PlayerFishEvent
  extend Purugin::Predicate

  # Will define predicates for all states of fishing events: state.fishing?, state.caught_fish?, etc...
  enum_predicates org.bukkit.event.player.PlayerFishEvent::State
end
