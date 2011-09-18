class NicknamePlugin
  include Purugin::Plugin
  description 'Nickname', 0.3
  
  def on_enable
    public_command('nick', 'change displayed name', '/nick {name}') do |sender, *args|
      nick = error? args[0], "Must specify a name"
      sender.display_name = nick
      sender.msg "Display name changed to #{nick}"
    end
  end
end
