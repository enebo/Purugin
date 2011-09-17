class NicknamePlugin
  include Purugin::Plugin
  description 'Nickname', 0.2
  required :Commands, :include => :Command
  
  def on_enable
    public_command('/nick', 'change displayed name') do |e, *args|
      nick = error? args[1], "Must specify a name (/nick frogger)"
      e.player.display_name = nick
      e.player.send_message "Display name changed to #{nick}"
    end
  end
end
