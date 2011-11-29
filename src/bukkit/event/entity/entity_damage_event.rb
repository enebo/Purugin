class org::bukkit::event::entity::EntityDamageEvent
  # Will define predicates for all DamageCauses: contact?, drowning?, lava?, etc...
  org.bukkit.event.entity.EntityDamageEvent::DamageCause.values.each do |cause|
    define_method(cause.name.downcase + "?") do
      self.cause == cause
    end
  end
end