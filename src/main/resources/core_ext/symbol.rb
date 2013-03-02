class Symbol
  ##
  # Makes a printable representation of this symbol, which matches Purugin better than to_s
  # === Examples ===
  # :pig_zombie.printable #=> "Pig Zombie"
  def printable
    to_s.split('_').map { |e| e.capitalize }.join(' ')    
  end
  
  ##
  # Retrieves the Material representable by this symbol.
  # === Examples ===
  # :gold_axe.to_material #=> org.bukkit.Material::GOLD_AXE
  def to_material
    org::bukkit::Material::match_material(to_s)
  end
end
