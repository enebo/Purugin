class AdminPlugin
  include Purugin::Plugin
  description 'Who', 0.2
  required :Commands, :include => :Command
  
  def on_enable
    public_command('/who', 'display all users') do |e, *|
      me = e.player
      me.world.players.each do |player|
        me.send_message "#{player.display_name} (#{player.name})"
      end
    end
  end
end
