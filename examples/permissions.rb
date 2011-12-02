class RubyPermissionsPlugin
  include Purugin::Plugin
  description 'RubyPermissions', 0.1

  def build?(player)
    true
  end

  def load_world(world)
  end

  def on_enable
    player_command('die', 'End it all...', '/die') do |me, *|
      me.msg "Goodbye cruel world!"
      me.health = 0
    end

    event(:world_load) { |event| load_world event.world }
    event(:block_place) { |event| build? event.player }
    event(:block_break) { |event| build? event.player }
  end
end
