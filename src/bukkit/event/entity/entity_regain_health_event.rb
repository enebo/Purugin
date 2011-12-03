require 'java'

class org::bukkit::event::entity::EntityRegainHealthEvent
  # Will define predicates for all Regain Health events: regen?, eating?, etc...
  org.bukkit.event.entity.EntityRegainHealthEvent::RegainReason.values.each do |cause|
    define_method(cause.name.downcase + "?") do
      self.cause == cause
    end
  end
end
