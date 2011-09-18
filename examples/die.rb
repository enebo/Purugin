class DeathPlugin
  include Purugin::Plugin
  description 'Death', 0.3

  def on_enable
    command('die', 'End it all...you are stuck') do |sender, *args|
      sender.health = 0
    end
  end
end
