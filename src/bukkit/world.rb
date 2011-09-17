require 'java'

module org::bukkit::World
  # Get the block at the given coordinates
  # === Parameters
  # * x,y,z - Give three coord. location
  # * location - Provide a location object
  # === Example
  # e.player.world.block_at(20, 20, 20) #=> Block instance
  # e.player.world.block_at(Location.new(20, 20, 20)) #=> ditto
  #
  def block_at(*r)
    getBlockAt *r
  end
  
  # Spawn a monster by name mob_name ("chicken", "creeper")
  # in the specified location
  def spawn_mob(mob_name, location)
    mob_type = org.bukkit.entity.CreatureType.from_name(mob_name.to_s.capitalize)
    
    raise TypeError.new "unknown mob type #{mob_name}" unless mob_type
    
    spawnCreature location, mob_type
  end
end
