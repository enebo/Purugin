class DeathPlugin
  include Purugin::Plugin
  description 'Death', 0.4

  def on_enable
    player_command('die', 'End it all...', '/die') do |me, *|
      me.msg "Goodbye cruel world!"
      me.health = 0
    end
  end
end
