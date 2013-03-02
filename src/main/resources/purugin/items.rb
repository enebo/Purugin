module Purugin
  ##
  # Use this module to include helper methods for dealing with the use and creation of items
  module Items
    include Purugin::ConversionUtils
    
    def item_stack(*args)
      args = scan_args({material: :convert_to_material}, 
        {count: :convert_to_int, durability: :convert_to_int, data: nil}, *args)
      org.bukkit.inventory.ItemStack.new *args
    end
  end
end
