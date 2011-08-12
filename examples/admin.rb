class AdminPlugin
  include Purugin::Plugin
  description 'Admin', 0.2
  required :Commands, :include => :Command
  
  def on_enable
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
