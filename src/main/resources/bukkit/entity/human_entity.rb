require 'java'
require 'bukkit/game_mode'

module org::bukkit::entity::HumanEntity  
  # Get get and/or set the game mode
  # 
  # === Parameters
  # * _mode_ the value to change between (e.g. :creative, :survival)
  # === Example
  # player.game_mode #=> :survival
  # player.game_mode :creative # Switch to creative mode
  # 
  def mode(mode=nil)
    return get_game_mode.to_s.downcase.to_sym unless mode

    # FIXME: Should this throw an exception?    
    bukkit_mode = org.bukkit.GameMode.string_as_mode(mode)
    set_game_mode bukkit_mode if bukkit_mode
  end
end
