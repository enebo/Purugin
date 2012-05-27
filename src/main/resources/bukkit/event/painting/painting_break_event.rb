require 'java'
require 'purugin/predicate'

class org::bukkit::event::painting::PaintingBreakEvent
  extend Purugin::Predicate

  # Will define predicates for all Paintint break events: fire?, water?, etc...
  enum_predicates org.bukkit.event.painting.PaintingBreakEvent::RemoveCause
end

