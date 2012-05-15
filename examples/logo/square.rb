turtle("square") do |*args|
  dim = args.length >= 1 ? args[0].to_i : 5

  4.times do
    forward dim
    turnleft 90
  end
end
