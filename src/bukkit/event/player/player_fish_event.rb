require 'java'

class org::bukkit::event::player::PlayerFishEvent
  # Will define predicates for all states of fishing events: fishing?, caught_fish?, etc...
  org.bukkit.event.player.PlayerFishEvent::State.values.each do |cause|
    define_method(cause.name.downcase + "?") do
      self.cause == cause
    end
  end
end
