class NicknamePlugin
  include Purugin::Plugin
  description 'Nickname', 0.1
  
  def on_enable
    include_plugin_module 'Commands', 'Command'

    command('/nick', 'change displayed name') do |e, *args|
      e.player.display_name = args[1]
      e.player.send_message "Display name changed to #{args[1]}"
    end
  end
end
