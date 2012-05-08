turtle do
  dimensions = 20
  pencolor :grass

  dimensions.times do |i|
    log "#{i}th iteration"
    forward dimensions
    backward dimensions
    turnleft 90
    forward 1
    turnright 90
  end
end


