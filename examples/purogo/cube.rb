turtle("cube", :pig) do |*args|
  length = (args[0] || 5).to_i
  block_type = (args[1] || :stone).to_sym

  # Set block to be used for all drawing
  block block_type  

  # Draw base of cube
  4.times do |i|
    mark i # Mark 4 lower corners
    forward length
    turnleft 90
  end

  # Draw one up pillar and save top of cube
  4.times do |i|
    goto i 
    turnup 90
    forward length
  end # Still at top of last pillar

  # Still pointing straight up after last draw turn back horizontal
  turndown 90

  # Draw top of cube
  4.times do |i|
    forward length
    turnleft 90
  end
end
