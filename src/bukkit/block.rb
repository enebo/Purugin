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
  # * _face_value_* can be :north, :east, :south, :west, :up, :down, :north_east, :north_west,
  #      :ne, :nw, :south_east, :south_west, :se, :sw, :self
  # === Examples
  # here.block_at(:north) #=> another earth block
  def block_at(face_value)
    face = face_for(face_value)
    
    return nil unless face
    
    get_relative(face)
  end
  
  def face_for(value)
    FACE_VALUES[value]
  end
  private :face_for
end
