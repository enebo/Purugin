require 'java'

module Purugin
  # Convenience methods useful for dealing with anything which works with Materials.  Block is
  # one type which includes this.
  module Materials
    # Is this block any of the supplied values (see MATERIAL_NAMES constant for a full list)?
    # === Parameters
    # * _values_ one or more symbols from MATERIAL_NAMES that you want to test against
    # === Example
    # grass_block.is? :grass        #=> true
    # grass_block.is? :wood, :stone #=> false
    #
    def is?(*values)
      !!values.find() {|value| type.is?(value) }
    end
    
    # Return the Java equivalent value for the specified material symbol/str
    def material_for(value)
      org.bukkit.Material.match_material value.to_s
    end
  end
end