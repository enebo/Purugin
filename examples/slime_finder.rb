class SlimePlugin
  include Purugin::Plugin, Purugin::Colors
  description 'Slime Finder', 0.1

  CHUNK_SIZE = 16

  def slime?(seed, x, z)
    random = java.util.Random.new(seed + x * x * 0x4c1906 + x * 0x5ac0db +
                                  z * z * 0x4307a7 + (z * 0x5f24f) ^ 0x3ad8025f)
    random.next_int(10) == 0
  end

  def slime_map(me, dim=4)
    dim = dim.to_i
    seed = me.world.seed
    chunk = me.world.get_chunk_at(me.location)

    (dim*2).times do |z|
      x_line = ""
      (dim*2).times do |x|
        real_x, real_z = (chunk.x + x - dim), (chunk.z + z - dim)

        if real_x == chunk.x && real_z == chunk.z
          x_line << (slime?(seed, real_x, real_z) ? red("#") : gray("#"))
        else 
          x_line << (slime?(seed, real_x, real_z) ? red("O") : gray("O"))
        end
      end
      me.msg x_line
    end
  end

  def is_slime(me)
    chunk = me.world.get_chunk_at(me.location)
    if slime?(me.world.seed, chunk.x, chunk.z)
      me.msg "You are in a slime chunk."
    else
      me.msg "You are not in a slime chunk."
    end
  end

  def is_slime_error(me, *args)
  end

  def slime_map_error(me, *args)
    me.msg "Something went wrong: #{args.join(', ')}"
  end

  def on_enable
    public_player_command('slime_map', 'print slime map', '| {dim}')
    public_player_command('is_slime', 'Am I in a slize chunk?', '|')
  end
end
