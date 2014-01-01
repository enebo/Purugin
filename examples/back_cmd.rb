# Exercise of writing Ruby versions from plugins in O'Reilly's
# Java Minecraft book.  Note: These were written from scratch and 
# the behavior is not neccesarily the same.  In this example it really 
# calculates your grade and is not simple hard-coded array access.

class BackCmdPlugin
  include Purugin::Plugin
  description 'BackCmd', 0.1

  SRC, DEST = 0, 1

  def same_loc?(this, that)
    this.x == that.x && this.z == that.z
  end

  def on_enable
    is_teleporting = []
    player_teleports = Hash.new([])

    event(:teleport) do |event|
      if is_teleporting.include? event.player
        is_teleporting.delete event.player
      else
        player_teleports[player] << [event.from, event.to] # SRC, DEST
      end
    end

    player_command('back', 'Goes back') do |me, *|
      locs = player_teleports[me]

      if !locs.empty? && same_loc?(locs[0][SRC], player.loc)
        is_teleporting << me
        me.teleport locs[0][DEST]
      else
        me.msg "You have not teleported yet"
      end
    end
  end
end
