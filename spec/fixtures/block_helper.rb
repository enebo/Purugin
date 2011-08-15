require 'bukkit/block'

# This represents a live version of a block.  Note that we cannot use
# real instances without actually using Craftbukkit and figuring out
# the appropriate bootstrapping
class SpecBlock
  include org.bukkit.block.Block

  def initialize(material_data, surrounding_block_data={})
    @material_data = material_data
    @surrounding_block_data = surrounding_block_data
  end

  def getRelative(face)
    if distance > -1
      # TODO
    else
      
    end
  end

  def getType()
    @material_data.item_type
  end
  alias :type :getType
end
