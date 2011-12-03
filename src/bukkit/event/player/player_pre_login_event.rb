require 'java'

class org::bukkit::event::player::PlayerPreLoginEvent
  # Will define predicates for all states of fishing events: allowed?, kick_other?, etc...
  org.bukkit.event.player.PlayerLoginEvent::Result.values.each do |cause|
    define_method(cause.name.downcase + "?") do
      self.cause == cause
    end
  end
end

