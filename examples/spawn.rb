class SpawnPlugin
  include Purugin::Plugin
  description 'Spawn', 0.1
  required :Commands, :include => :Command
  
  def on_enable
    public_command('/spawn', 'spawn a mob') do |e, *args|
      mob_name = error? args[0], "Must specify a mob name"
      time = args.length > 1 ? args[1] : 0;
      time = error? time.to_i, "Time must be a valid integer"
      error? time >= 0, "Time must be a positive integer"
      
      Thread.new do # Don't lock down the server while waiting
        sleep time if time > 0
        loc = e.player.target_block.block_at(:up).location
        e.player.world.spawn_mob(mob_name, loc)
      end
    end
  end
end
