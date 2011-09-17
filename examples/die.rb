class DeathPlugin
  include Purugin::Plugin
  description 'Death', 0.2
  required :Commands, :include => :Command

  def on_enable
    command('/die', 'End it all...you are stuck') do |e, *args|
      e.player.health = 0
    end
  end
end
