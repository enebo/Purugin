class Symbol
  ##
  # Makes a printable representation of this symbol, which matches Purugin better than to_s
  # === Examples ===
  # :pig_zombie.printable #=> "Pig Zombie"
  def printable
    to_s.split('_').map { |e| e.capitalize }.join(' ')    
  end
end
