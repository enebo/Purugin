class DeathPlugin
  include Purugin::Plugin
  description 'Death', 0.4

  def on_enable
    player_command('die', 'End it all...you are stuck') do |sender, *|
      sender.health = 0
    end
  end
end
