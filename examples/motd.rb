class MOTDPlugin
  include Purugin::Plugin
  description 'Message of the day', 0.3

  def on_enable
    config = load_configuration
    motd = config.get_string("motd.message", "Welcome!")
    
    event(:player_join) do |e|
      motd.split(/\n/).each do |line|
        e.player.send_message line
      end
    end
  end
end
