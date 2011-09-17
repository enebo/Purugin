require 'java'

module org::bukkit::entity::LivingEntity
  def living?
    true
  end
  
  # Get the block that the player has targeted.  Note: this is a Ruby convenience method
  # for Bukkit's LivingEntity getTargetBlock(HashSet<Byte>, int).
  # 
  # === Parameters
  # * _blocks_to_ignore_ hash of blocks you wish to ignore (optional, defaults to [:air])
  # * _max_distance_ maximum_distance to look for a targeted block
  # === Example
  # player.target_block #=> block which is targeted
  # player.target_block [:earth, :air] #=> ignore eatch and air
  # player.target_block nil, 100 #=> Allow targetting 100 voxels away
  # 
  def target_block(blocks_to_ignore=nil, max_distance=30)
    block_id_map = blocks_to_ignore
    get_target_block block_id_map, max_distance
  end
end