require 'java'

module org::bukkit::World
  # Spawn a monster by name mob_name ("chicken", "creeper")
  # in the specified location
  def spawn_mob(mob_name, location)
    mob_type = org.bukkit.entity.CreatureType.from_name(mob_name.to_s.capitalize)
    
    raise TypeError.new "unknown mob type #{mob_name}" unless mob_type
    
    spawnCreature location, mob_type
  end
end
