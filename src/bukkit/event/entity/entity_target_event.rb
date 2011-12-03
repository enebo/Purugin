require 'java'

class org::bukkit::event::entity::EntityTargetEvent
  # Will define predicates for all Target events: target_died?, random_target?, etc...
  org.bukkit.event.entity.EntityTargetEvent::TargetReason.values.each do |cause|
    define_method(cause.name.downcase + "?") do
      self.cause == cause
    end
  end
end

