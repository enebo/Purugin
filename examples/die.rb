class DeathPlugin
  include Purugin::Plugin, Purugin::Colors
  description 'Death', 0.1
  required :Commands, :include => :Command

  def on_enable
    command('/die', 'End it all...you are stuck') do |e, *args|
      e.player.health = 0
    end
  end
end
