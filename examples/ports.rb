# Allow placed signs to behave as a teleporter when right clicked on.  The format
# for the sign is line one containing 'Teleporter' and line two containing either:
# a) x, y, z (base 36 offset by +32000) b) {locs_plus_waypoint_name}. In the case of b it 
# will substitute that name with the loc it represents when the sign is placed. You can write
# anything on lines 3 or lower and it will not affect how the sign works as a teleporter.
class PortsPlugin
  include Purugin::Plugin, Purugin::Colors
  description 'Ports', 0.3
  required :LocsPlus, :include => :CoordinateEncoding
  
  def teleporter_loc(state)
    return nil if state.lines.length < 2 || state.get_line(0) != "Teleporter"
    state.get_line(1)
  end
  
  SAFE_BLOCKS = [:air, :water]
  
  def safe_loc?(me, bottom_block)
    top_block = bottom_block.block_at(:up)
    floor_block = bottom_block.block_at(:down)
    top_block.is?(*SAFE_BLOCKS) && bottom_block.is?(*SAFE_BLOCKS) && 
      floor_block.solid?
  end

  # Attempts to find a safe location when block under your feet is solid
  # and where both blocks your player occupies are either air or water.
  # The algorithm is to try the location you want. If it does not work then
  # try all adjacent squares.  If that does not work go up one and repeat.
  # This will fail after limit tries.
  def safe_loc(me, world, location, limit = 5)
    return nil if limit <= 0
    bottom_block = world.block_at(location)
    return location if safe_loc?(me, bottom_block)

    [:north, :east, :west, :south].each do |direction|
      alt_block = bottom_block.block_at(direction)
      return alt_block.location if safe_loc?(me, alt_block)
    end
      
    return safe_loc(me, world, location.add(0, 1, 0), limit - 1)
  end
  
  def on_enable
    event(:player_interact) do |e|
      if e.right_click_block? && e.clicked_block.is?(:sign_post, :wall_sign)
        loc = teleporter_loc e.clicked_block.state
        return unless loc 
        
        if loc =~ /([^\x00-\x7F].)?([0-9a-z]+)\s*,\s*([0-9a-z]+)\s*,\s*([0-9a-z]+)/u
          x, y, z = $2, $3, $4
          destination = org.bukkit.Location.new e.player.world, decode(x), decode(y), decode(z)

          destination = safe_loc(e.player, e.player.world, destination)
          if destination
            server.scheduler.schedule_sync_delayed_task(self) { e.player.teleport destination }
          else
            e.player.msg red("Crud at destination!")
          end
        end
      end
    end

    # When signs are placed it will look for {my_waypoint} on the loc line.  If it finds
    # this it will ask LocsPlus plugin if such a waypoint exists.  If so it substitures the 
    # the loc in for the name.    
    event(:sign_change) do |e|
      loc = teleporter_loc e
      return unless loc
      if loc =~ /\{([^}]+)\}/
        waypoint = $1
        begin
          loc = LocsPlus().location(e.player, waypoint).to_a
        rescue ArgumentError
          e.player.msg red($!.message)
          break
        end
      end
      
      e.lines.to_a.each_with_index do |line, i|
        if i == 1 && loc
          e.set_line i, gray(loc[0..2].to_a.map {|l| encode(l) }.join(","))
        elsif i == 2 and line == "" && waypoint
          e.set_line i, green(waypoint)
        else
          e.set_line i, colorize(line)
        end
      end
    end
  end
end
