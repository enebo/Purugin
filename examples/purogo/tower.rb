turtle("tower") do
  # Draw base of cube
  square do
    4.times do |i|
      mark i
      forward 5
      turnleft 90
    end
  end

  pillars do
    4.times do |i|
      goto i 
      turnup 90
      forward 5
    end # Still at top of last pillar
    turndown 90
  end

  3.times do
    square 
    pillars
  end
  square
end

