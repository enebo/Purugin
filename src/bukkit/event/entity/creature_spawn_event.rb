require 'java'

class org::bukkit::event::entity::CreatureSpawnEvent
  # Will define predicates for all Creature Spawns: egg?, spawner?, etc...
  org.bukkit.event.entity.CreatureSpawnEvent::SpawnReason.values.each do |cause|
    define_method(cause.name.downcase + "?") do
      self.cause == cause
    end
  end
end