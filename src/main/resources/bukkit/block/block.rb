require 'java'
require 'purugin/materials'

class cb::block::CraftBlock
  include Purugin::Materials
  BF = org.bukkit.block.BlockFace
  FACE_VALUES = {
    :north => BF::NORTH, :east => BF::EAST, :south => BF::SOUTH, :west => BF::WEST,
    :up => BF::UP, :down => BF::DOWN, :north_east => BF::NORTH_EAST, :north_west => BF::NORTH_WEST,
    :ne => BF::NORTH_EAST, :nw => BF::NORTH_WEST, :south_east => BF::SOUTH_EAST, 
    :south_west => BF::SOUTH_WEST, :se => BF::SOUTH_EAST, :sw => BF::SOUTH_WEST, :self => BF::SELF
  }
  ROTATIONS = {
    :north => {:left => :east, :right => :west, :up => :down, :down =>:up}, 
    :east => {:left => :south, :right => :north, :up => :down, :down =>:up},
    :south => {:left => :west, :right => :east, :up => :down, :down =>:up},
    :west => {:left => :north, :right => :south, :up => :down, :down =>:up},
    :up => {:left => :east, :right => :west, :up => :north, :down =>:south},
    :down => {:left => :east, :right => :west, :up => :south, :down =>:north}
  }
  
  ##
  # Find a nearby block relative to the current block based on a friendly symbol name
  # === Parameters
  # * _face_* can be :north, :east, :south, :west, :up, :down, :north_east, :north_west,
  #      :ne, :nw, :south_east, :south_west, :se, :sw, :self
  # * _distance_ * this is optional and defaults to 1.  # of blocks from this block
  # === Examples
  # here.block_at(:north) #=> another earth block
  def block_at(face_parm, distance=nil)
    face = face_for_symbol(face_parm) || face_parm

    return nil unless face
    
    distance ? get_relative(face, distance) : get_relative(face)
  end
  alias :relative :block_at
  
  ##
  # Type of this block (as a Material)
  def type
    getType
  end
  
  ##
  # How bright is the light on this block?  Can be 0-15.
  #
  def light_level
    getLightLevel
  end
  
  ##
  # How bright is this block only from sky light?
  #
  def light_from_sky
    getLightFromSky
  end
  
  ##
  # How bright is this block from block source (not sky light)?
  #
  def light_from_blocks
   getLightFromBlocks 
  end
  
  ##
  # What world does this block belong to?
  def world
    getWorld
  end
  
  ##
  # x location of this block (Fixnum)
  def x
    getX
  end
  
  ##
  # y location of this block (Fixnum)
  def y
    getY
  end

  ##
  # z location of this block (Fixnum)
  def z
    getZ
  end
  
  ##
  # Current location of this block
  # === Parameters
  # * _location_ - Optional location in case you want to use an instance instead of construct a new one
  def location(location=nil)
    if location
      getLocation(location)
    else
      getLocation
    end
  end
  
  ##
  # What chunk does this block belong to?
  def chunk
    getChunk
  end
  
  ##
  # Some methods will implicitly convert a block to its location if it responds to :to_loc
  def to_loc
    location
  end
  
  ##
  # Change the type of this block to be another type.
  # Deprecated
  def change_type(new_type)
    setType(material_for(new_type) || new_type)
  end

  ##
  # Change the type of this block to be another type.
  #   
  def type=(new_type)
    setType(material_for(new_type) || new_type)
  end
  
  ##
  # Which face relative to the supplied block would be visible?
  # === Parameters
  # * _other_block_ - the block we want to compare against
  #
  def face_for(other_block)
    getFace(other_block)
  end
  alias :face :face_for
  
  ##
  # Gets any BlockState data associated with this block
  #
  def state
    getState
  end
  
  ##
  # Retrieve or change the biome associated with this block?
  # === Examples
  # me.target_block.biome #=> org.bukkit.block.Biome::Swamp
  #
  def biome
    getBiome
  end
  
  ##
  # Change the biome of this block.
  # === Parameters
  # * _new_biome_ change this block to the new biome type
  # 
  #  Note: If you expect
  # to see visual changes on your client after making this change you must call
  # World.refresh_chunk(x,z) on the chunk this block is contained in to have
  # client notice this change (this is expensive so it is not automatic).
  #
  # === Examples
  # me.target_block.biome = :forest
  #
  def biome=(new_biome)
    value = new_biome.respond_to?(:to_biome) ? new_biome.to_biome : new_biome

    raise ArgumentError.new "Invalid biome type: #{new_biome}" if !value.kind_of? org.bukkit.block.Biome

    setBiome(value)
  end
  
  ##
  # Does redstone power this block?
  def block_powered?
    isBlockPowered
  end
  
  ##
  # Does redstone indirectly power this block?  
  def block_indirectly_powered?
    isBlockIndirectlyPowered
  end
  
  ##
  # Does redstone power this block face?
  def block_face_powered?(face)
    isBlockFacePowered(symbol_for_face(face))
  end
  
  ##
  # Does redstone indirectly power this block?  
  def block_face_indirectly_powered?(face)
    isBlockFaceIndirectlyPowered(symbol_for_face(face))
  end
  
  ##
  # return the face relative to the supplied face given a direction
  def rotate(face, direction)
    face_for_symbol(ROTATIONS[symbol_for_face(face)][direction])
  end
  
  ##
  # Break (e.g. destroy) this block and possibly leave a dropped item behind
  # === Parameters
  # * _with_drop_* will drop an item if it is a droppable type (def: false)
  # * _replace_type_* replace this block with another type (def: air)
  # === Examples
  # bad_block.break!      # replaces it with air and not dropped item to pick up
  # bad_block.break! true # same as above but it leaves an item to pick up
  # bad_block.break! true, :stone # drops item and replaces broken block with stone
  def break!(with_drop=false, replace_type=:air)
    droppable = !is?(:air, :water, :lava)
 
    # Only drop items which are actually droppable    
    if with_drop && droppable
      itemstack = org::bukkit::inventory::ItemStack.new(type, 1)
      location.world.drop_item_naturally(location, itemstack)
    end
    
    change_type replace_type unless type.is? replace_type
  end
  
  def face_for_symbol(value)
    FACE_VALUES[value]
  end
  private :face_for_symbol
  
  def symbol_for_face(value)
    # oh-my... ruby<1.9 hashes dont have key()?!
    FACE_VALUES.invert[value]
  end
  private :symbol_for_face
  
  def inspect
    "Block: #{self.type}"
  end  
end
