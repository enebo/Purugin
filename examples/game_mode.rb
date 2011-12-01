class GameModePlugin
  include Purugin::Plugin, Purugin::Colors
  description 'Gamemode', 0.1

  def creative(me)
    me.msg yellow('Your game mode has been changed to creative!')
    me.mode :creative
  end

  def survival(me)
    me.msg yellow('Your game mode has been changed to survival!')
    me.mode :survival
  end
  
  def on_enable
    player_command('survival', 'Enter survival mode.') { |me, *| survival me }
    player_command('creative', 'Enter creative mode.') { |me, *| creative me }
    player_command('mode', 'Toggle between creative/survial mode.') do |me, *|
      if me.mode == :creative
        survival me
      else
        creative me
      end
    end
  end
end
