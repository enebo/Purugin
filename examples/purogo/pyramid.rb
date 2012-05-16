turtle("four-sided triangle") do |*args|
  dim = (args[0] || 5).to_i
  block_type = (args[1] || :stone).to_sym

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
  (1...dim).step(2).to_a.reverse.each do |i|
    dim = i
    layer
    pivot
  end
end

