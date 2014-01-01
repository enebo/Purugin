require 'java'
require 'purugin/predicate'

module org::bukkit::World
  extend Purugin::Predicate
  
  ##
  # Get the block at the given coordinates
  # === Parameters
  # * _x_,_y_,_z_ - Give three coord. location
  # * _location_ - Provide a location object
  # === Examples
  # e.player.world.block_at(20, 20, 20) #=> Block instance
  # e.player.world.block_at(Location.new(20, 20, 20)) #=> ditto
  #
  def block_at(*r)
    getBlockAt *r
  end
  
  ##
  # Gets the chunk that this location is within.
  # === Parameters
  # * _location_ - location within the chunk you are asking for
  # === Examples
  # e.player.world.chunk_at(me)  #=> Location coerced from your location
  # e.player.world.chunk_at(some_location) #=> Give an explicit location
  def chunk_at(location)
    location = location.respond_to?(:to_loc) ? location.to_loc : location
    
    getChunkAt(location)
  end
  
  ##
  # Get the highest non-air block in the y dimension of the supplied locations x,z
  # coordinate.
  # === Parameters
  # * _location_ - x,z location you want highest y non-air block
  # === Examples
  # e.player.world.highest_block_at(me)  #=> Location coerced from your location
  # e.player.world.highest_block_at(some_location) #=> Give an explicit location
  #
  def highest_block_at(location)
    location = location.respond_to?(:to_loc) ? location.to_loc : location
    
    getHighestBlockAt location
  end
  
  ##
  # Spawn a creature ("chicken", "creeper") at a specified location.
  # === Parameters
  # * _mob_name_ is the creature to spawn (@see CreatureType)
  # * _location_ is where to put the spawned creature [note: to_loc coercion possible]
  # === Examples
  # e.player.world.spawn_mob(:chicken, e.player.location)
  #
  def spawn_mob(creature_name, location)
    creature_type = org.bukkit.entity.EntityType.from_name(creature_name.to_s)
    
    raise TypeError.new "unknown mob type #{creature_name}" unless creature_type
    
    location = location.respond_to?(:to_loc) ? location.to_loc : location
    spawnCreature location, creature_type
  end
  
  ##
  # Is the world experiencing a storm currently
  def storming?
    has_storm
  end
  
  ##
  # Get the biome associated with the provided location
  # === Parameters
  # * _location_ place you want the biome for
  # === Example
  # me.world.biome(me)
  #
  def biome(location)
    location = location.respond_to?(:to_loc) ? location.to_loc : location
    
    getBiome(location.x, location.z)
  end
  
  ##
  # Is this world the type you think it is?
  # === Parameters
  # * environment_name is a str or symbol mapping to world you are checking against.
  # === Example
  # me.world.is? :nether
  # === Notes
  # Consider also using the direct env methods if you know for sure that a world environment
  # exists on your server:
  # me.world.nether?
  def is?(environment_name)
    environment_name.to_s.upcase == environment.name
  end

  enum_predicates org.bukkit.World::Environment
  
  # Define one method for each environment (e.g. nether?, normal? skylands?)
  org.bukkit.World::Environment.values.each do |environment|
    pred_name = environment.kind.to_s + '?'
    eval "def #{pred_name}; environment.#{pred_name}; end"
  end
end
