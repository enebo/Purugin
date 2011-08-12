require 'java'

module org::bukkit::block::Block
  def inspect
    "Block: #{self.type}"
  end
end
