class SpawnPlugin
  include Purugin::Plugin, Purugin::Tasks
  description 'Spawn', 0.3
  
  def on_enable
    player_command('spawn', 'spawn a mob', '/spawn {name} {secs}?') do |me, *args|
      mob_name = error? args[0], "Must specify a mob name"
      time = args.length > 1 ? args[1] : 0;
      time = error? time.to_i, "Time must be a valid integer"
      error? time >= 0, "Time must be a positive integer"
      
      sync_task(time) do
        spawn_block = me.target_block.block_at(:up)
        me.world.spawn_mob(mob_name, spawn_block)
      end
    end
  end
end
