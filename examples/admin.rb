class AdminPlugin
  include Purugin::Plugin
  description 'Admin', 0.1
  
  def on_enable
    include_plugin_module 'Commands', 'Command'

    command('/loc', 'display current location') do |e, *args|
      l = e.player.location
      e.player.send_message format("loc: %0.2f, %0.2f, %0.2f", l.x, l.y, l.z)
    end
    command('/time', 'change time +n hours') do |e, *args| 
      e.player.world.time = args[1].to_i
    end
    command('/who', 'display all users') do |e, *args|
      me = e.player
      me.world.players.each do |player|
        me.send_message "#{player.display_name} (#{player.name})"
      end
    end
  end
end
