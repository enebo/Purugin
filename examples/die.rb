class DeathPlugin
  include Purugin::Plugin, Purugin::Colors
  description 'Death', 0.1
  attr_reader :commands

  def on_enable
    include_plugin_module 'Commands', 'Command'

    command('/die', 'End it all...you are stuck') do |e, *args|
      e.player.health = 0
    end
  end
end
