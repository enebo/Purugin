class SpawnPlugin
  include Purugin::Plugin
  description 'Spawn', 0.2
  
  def on_enable
    command('spawn', 'spawn a mob', '/spawn {name} {future_secs}?') do |sender, *args|
      mob_name = error? args[0], "Must specify a mob name"
      time = args.length > 1 ? args[1] : 0;
      time = error? time.to_i, "Time must be a valid integer"
      error? time >= 0, "Time must be a positive integer"
      
      Thread.new do # Don't lock down the server while waiting
        sleep time if time > 0
        spawn_block = sender.target_block.block_at(:up)
        sender.world.spawn_mob(mob_name, spawn_block)
      end
    end
  end
end
