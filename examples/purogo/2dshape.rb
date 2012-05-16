#Chaazd, WTFPL
#Makes most, if not all 2D shape 'drawers' obsolete.
turtle("2dshape", :chicken) do |*args|
  sides = (args[0] or 4).to_i 
  length = (args[1] or 5).to_i
  block_type = (args[2] or :stone).to_sym
  angle = 360 / sides # According to sides creates exterior angles. 360 / 4 would be 90, and therefor create a square.
  
  # Set type for block
  block block_type
  
  # Draw shape
  sides.times do
    forward length
    turnleft angle
  end
end
