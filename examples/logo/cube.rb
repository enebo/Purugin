turtle do
  # Draw base of cube
  4.times do |i|
    mark i # Mark 4 lower corners
    forward 5
    turnleft 90
  end

  # Draw one up pillar and save top of cube
  4.times do |i|
    goto i 
    turnup 90
    forward 5
  end # Still at top of last pillar

  turndown 90

  # Draw top of cube
  4.times do |i|
    forward 5
    turnleft 90
  end
end
