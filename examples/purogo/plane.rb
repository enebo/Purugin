# Make an dimension x dimension grid of blocks
turtle("plane") do |*args|
  dimensions = (args[0] or 20).to_i
  block (args[1] or :grass).to_sym

  i = dimensions 
  unit do
    forward i
    turnleft 90
  end
  
  # The four units are show to the right of this while loop
  # First one is longest.  Second and third are one shorter.
  # The Fourth is two shorter.  Next loop will is shown 
  # in the second box we can see steps 5-8.  At this point i
  # is 1 and we exit the while.  Leaving a single unit of 1
  # to draw the final block.
  while i >= 2         # 12222 12222
    unit               # 1###3 15663
    i -= 1             # 1###3 15#73
    2.times { unit }   # 1###3 15873
    i -= 1             # 14443 14443
    unit               
  end
  unit
end
