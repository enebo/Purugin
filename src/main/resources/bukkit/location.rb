class org::bukkit::Location
  def to_a
    [getX, getY, getZ, pitch, yaw]
  end
  
  def self.from_a(arr)
    org.bukkit.Location.new(nil, *arr)
  end
end