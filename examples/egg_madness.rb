# This example allows each user to control what comes out of eggs that they
# throw.  You can pick a create like a cow and issue the command:
#
# /egg_spawn cow
#
# The next time you throw an egg you will get a cow.  You can also specify
# how many you want:
#
# /egg_count 2
#
# Now you will get 2 cows.
#
class EggMadnessPlugin
  include Purugin::Plugin, Purugin::PlayerStorage
  description 'EggMadness', 0.1

  DEFAULT_COUNT, DEFAULT_MOB = 1, :chicken

  def egg_count(me, num) 
    storage_for(me)[:egg_count] = num
    me.msg "Mob count changed to #{num}"
  end

  def egg_spawn(me, mob)
    storage_for(me)[:spawn_type] = mob
    me.msg "Egg spawn changed to #{mob}"
  end

  def on_enable
    command_type('spawnable') do |sender, name|
      entity = coerce('entity', sender, name)
      error? entity.spawnable?, "Not a spawnable creature: '#{name}'"
      entity
    end

    public_command!('egg_count', '# of spawns.', '{num:byte}')
    public_command!('egg_spawn', 'type of egg spawn.', '{mob:spawnable}')

    event(:player_egg_throw) do |e|
      e.hatching = true
      e.num_hatches = storage_for(e.player).fetch(:egg_count, DEFAULT_COUNT).to_java(:byte)
      e.hatching_type = storage_for(e.player).fetch(:spawn_type, DEFAULT_MOB)
    end
  end
end
