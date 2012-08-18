class EggMadnessPlugin
  include Purugin::Plugin
  description 'EggMadness', 0.1

  # FIXME: Add into purugin API's somewhere
  def creature_type(name)
    org.bukkit.entity.CreatureType.from_name(name.to_s.capitalize) 
  end

  def on_enable
    egg_count = 1
    spawn_type = creature_type(:chicken)

    player_command('egg_count', '# of spawns.') do |me, *args|
      error? args.length >= 1, "must supply arg"
      egg_count = error? args[0].to_i, "Not an fixnum"
    end

    player_command('egg_spawn', 'type of egg spawn.') do |me, *args|
      error? args.length >= 1, "must supply arg"
      creature = creature_type(args[0])
      error? creature.nil?, "No such creature #{args[0]}"
      spawn_type = creature
    end

    event(:player_egg_throw) do |event|
      event.hatching = true
      event.num_hatches = egg_count.to_java(:byte)
    end
  end
end
