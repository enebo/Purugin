require 'java'
require 'purugin/materials'

module org::bukkit::block::Block
  include Purugin::Materials
  BF = org.bukkit.block.BlockFace
  FACE_VALUES = {
    :north => BF::NORTH, :east => BF::EAST, :south => BF::SOUTH, :west => BF::WEST,
    :up => BF::UP, :down => BF::DOWN, :north_east => BF::NORTH_EAST, :north_west => BF::NORTH_WEST,
    :ne => BF::NORTH_EAST, :nw => BF::NORTH_WEST, :south_east => BF::SOUTH_EAST, 
    :south_west => BF::SOUTH_WEST, :se => BF::SOUTH_EAST, :sw => BF::SOUTH_WEST, :self => BF::SELF
  }
  
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
  
  # Which face relative to the supplied block would be visible?
  # === Parameters
  # * _other_block_ - the block we want to compare against
  def face_for(other_block)
    get_face(other_block)
  end
  
  # Some methods will implcitly convert a block to its location if it responds to :to_loc
  def to_loc
    location
  end
  
  # Wrapper around setType to allow specifying material types by symbol.
  # Note: Not sure what the error should be if improperly specified
  def change_type(new_type)
    new_type = material_for(new_type) if new_type.kind_of? Symbol
    return unless new_type
    set_type new_type
  end
  
  def face_for_symbol(value)
    FACE_VALUES[value]
  end
  private :face_for_symbol
  
  def inspect
    "Block: #{self.type}"
  end  
end