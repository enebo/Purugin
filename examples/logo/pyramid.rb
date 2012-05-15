turtle("four-sided triangle") do
  block_type = :sandstone
  dim = nil

  layer do
    4.times do |i|
      forward dim
      turnleft 90
    end
  end
  
  pivot do
    block :none
    forward 1
    turnleft 90
    forward 1
    turnup 90
    forward 1
    turndown 90
    turnright 90
    block block_type
  end

  block block_type
  (1...18).step(2).to_a.reverse.each do |i|
    dim = i
    layer
    pivot
  end
end

