require 'java'

class org::bukkit::event::entity::CreeperPowerEvent
  # Will define predicates for all Powering events: lightning?, set_on?, set_off?
  org.bukkit.event.entity.CreeperPowerEvent::PowerCause.values.each do |cause|
    define_method(cause.name.downcase + "?") do
      self.cause == cause
    end
  end
end