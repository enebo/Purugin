turtle("cube", :pig) do |*args|
if args[0] >= 1
  length = 5
else
  length = args[0].to_i
end
if args[1] == nil
  block_type = :stone
else
  block_type = args[1].to_sym
end
  
  # Draw base of cube
  4.times do |i|
    mark i # Mark 4 lower corners
    block block_type
    forward length
    turnleft 90
  end

  # Draw one up pillar and save top of cube
  4.times do |i|
    block block_type
    goto i 
    turnup 90
    forward length
  end # Still at top of last pillar

  turndown 90

  # Draw top of cube
  4.times do |i|
    block block_type
    forward length
    turnleft 90
  end
end