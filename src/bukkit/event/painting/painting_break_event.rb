require 'java'

class org::bukkit::event::painting::PaintingBreakEvent
  # Will define predicates for all Paintint break events: fire?, water?, etc...
  org.bukkit.event.painting.PaintingBreakEvent::RemoveCause.values.each do |cause|
    define_method(cause.name.downcase + "?") do
      self.cause == cause
    end
  end
end

