turtle("Cube using n-planes via draw") do |*args|
  dimension = (args[0] or 5).to_i
  block_type = (args[1] or :glass).to_sym

  go_up do
    block :none
    turnup 90
    forward 1
    turndown 90
  end

  dimension.times do
    mark 'start'
    draw 'plane', dimension, block_type
    goto 'start'
    go_up
  end
end
