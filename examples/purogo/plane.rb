# Make an dimension x dimension grid of blocks
turtle("plane") do |dim, *args|
  dimensions = (dim or 20).to_i

  i = dimensions 
  unit do
    i.times do
      block random(*args)
      forward 1
    end
    turnleft 90
  end

  # Basic explanation of this algorithm is that we draw one line the length
  # of the plane we want to construct (seen as 1 in box to right of while loop
  # drawn bottom to top).  Next we enter the 2.times and draw two more lines 
  # (via unit) which is one shorter than dimension (seen as 'a' and then 'b').
  # The second time through the outer 2.times we decrement and then write 'c' 
  # and 'd'.  Then 'e' and 'f'. and finally 'g' and 'h'.
  unit
  while i > 1          # dimension = 5
    2.times do         #
      i -= 1           # 1aaaa
      2.times { unit } # 1deeb
    end                # 1dhfb
  end                  # 1dgfb
end                    # 1cccb
