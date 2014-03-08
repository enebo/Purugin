require 'java'
require 'purugin/predicate'

class cb::CraftWorld
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
  # Is the provided chunk currently loaded by this world.  This also can be called
  # with the
  # === Parameters
  # * _chunk_or_x_ * - is the chunk instance you are inquiring about or it is x coordinate
  # * z * - is optional for the [x,y] version of this method.
  # === Examples
  # e.player.world.chunk_loaded? some_chunk
  # e.player.world.chunk_loaded?(30, 13)
  def chunk_loaded?(chunk_or_x, z=nil)
    z ? isChunkLoaded(chunk_or_x, z) : isChunkLoaded(chunk_or_x)
  end

  ##
  # Is the chunk being actively used by players (also must be loaded).
  # === Parameters
  # _x_ - x coordinate of chunk
  # _z_ - z coordinate of chunk
  def chunk_in_use?(x, z)
    isChunkInUse(x, z)
  end

  ##
  # Drop the specified item (ItemStack) at the specified location.
  # === Parameters
  # * _location_ - where you want to drop the item (Location, to_loc)
  # * _item_ - ItemStack you want to drop
  # * _naturally_ - whether you want a little offset randomness added (defaults false)
  # === Examples
  # fence = item_stack(:fence, 1)
  # e.player.world.drop_item(e.player, fence) # drops item at players location
  #
  # # drops but add small amount of randomness to location
  # e.player.world.drop_item(e.player, fence, true)
  #
  def drop_item(location, item, naturally=false)
    location = location.respond_to?(:to_loc) ? location.to_loc : location

    naturally ? dropItemNaturally : dropItem(location, item)
  end

  ##
  # Generate a Tree and the specified location
  # === Parameters
  # * _location_ - where you want the tree
  # * _tree_type_ - which type of tree you want
  # * _delegate_ - (optional) FIXME: untested.  Pass in impl of BlockChangeDelegate.
  # === Examples
  # e.player.world.generate_tree(e.player, :mega_redwood)
  def generate_tree(location, tree_type, delegate=nil)
    location = location.respond_to?(:to_loc) ? location.to_loc : location
    tree_type = tree_type.respond_to?(:to_tree) ? tree_type.to_tree : tree_type

    delegate ? generateTree(location, tree_type, delegate) : generateTree(location, tree_type)
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
  # Get the highest non-air block's y coordinate of the supplied locations x,z
  # coordinate.
  # === Parameters
  # * _location_ - x,z location you want highest y non-air block
  # === Examples
  # e.player.world.highest_block_y_at(me)  #=> 13
  # e.player.world.highest_block_y_at(some_location) #=> 13
  #
  def highest_block_y_at(location)
    location = location.respond_to?(:to_loc) ? location.to_loc : location

    getHighestBlockYAt location
  end

  ##
  # Load the chunk at [x,z] and choose whether you want it generated or not (default: true).
  # === Parameters
  # _x_ - x coordinate of chunk
  # _z_ - z coordinate of chunk
  # _generate_ - should the chunk get generated if it hasn't before (default: true)
  def load_chunk(x, z, generate=true)
    loadChunk(x, z, generate)
  end

  ##
  # Returns an Array of loaded chunks (Java version returns Java primitive array).
  #
  def loaded_chunks
    getLoadedChunks.to_a
  end
  
  ##
  # Regenerate the chunk at [_x_, _z_].
  # === Parameters
  # _x_ - x coordinate of chunk
  # _z_ - z coordinate of chunk  
  def regenerate_chunk(x, z)
    regenerateChunk(x, z)  
  end
  
  ##
  # Refreshes the chunk at [_x_, _z_].
  # === Parameters
  # _x_ - x coordinate of chunk
  # _z_ - z coordinate of chunk  
  def refresh_chunk(x, z)
    refreshChunk(x, z)
  end

  ##
  # Spawn and fire an arrow from the current location.
  # === Parameters
  # * _location_ -
  # * _direction_ -
  # * _speed_ -
  # * _spread_ -
  # === Examples
  # arrow = e.player.world.spawn_arrow(e.player, e.player.eye_location.direction.multiple(2))
  # arrow.shooter = e.player
  def spawn_arrow(location, direction, speed=0.6, spread=12)
    location = location.respond_to?(:to_loc) ? location.to_loc : location
    
    spawnArrow(location, direction, speed, spread)
  end

  ##
  # Spawn an entity at the given location
  # === Parameters
  # * _location_ - where you want the entity to spawn
  # * _entity_type_ - which entity do you want (:cow)
  # === Examples
  #
  def spawn_entity(location, entity_type)
    location = location.respond_to?(:to_loc) ? location.to_loc : location
    entity_type = entity_type.respond_to?(:to_entity) ? entity_type.to_loc : entity_type

    spawnEntity(location, entity_type)
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

  def strike_lightning(location, effect_only=false)
    location = location.respond_to?(:to_loc) ? location.to_loc : location
    
    effect_only ? strikeLightningEffect(location) : strikeLightning(location)
  end

  ##
  # Unload the chunk at [x,z] and choose whether it should be saved away (_save_: true) and
  # whether we should care if players are close to that chunk or not (_safe_: true).
  # === Parameters
  # _x_ - x coordinate of chunk
  # _z_ - z coordinate of chunk
  # _save_ - save the chunk to disk
  # _safe_ - only unload it is no players are close enough to notice
  def unload_chunk(x, z, save=true, safe=true)
    unloadChunk(x, z, save, safe)
  end

  ##
  # Sends a request to specify you want to unload a chunk at [x,z].  Optionally, you can
  # specify whether you want this operation to be safe or not (_safe_: true).
  # === Parameters
  # _x_ - x coordinate of chunk
  # _z_ - z coordinate of chunk
  # _safe_ - only unload it is no players are close enough to notice
  def unload_chunk_request(x, z, safe=true)
    unloadChunkRequest(x, z, safe)
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
