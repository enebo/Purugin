require 'java'

class org::bukkit::util::Vector
  alias :x= :setX
  alias :y= :setY
  alias :z= :setZ
  
  def inspect
    format "Vector(%0.2f,%0.2f,%0.2f)", x, y, z
  end
end

