class LocsPlus
  include Purugin::Plugin, Purugin::Colors
  description 'LocsPlus', 0.3
  required :Commands, :include => :Command
  
  def dirify(value, positive, negative)
    value < 0 ? [value.abs, negative] : [value, positive]
  end  

  def loc_string(name, player, x, y, z, pitch, yaw)
    distance = distance_from_loc(player, x, y, z)
    l = player.location
    x1, z1, y1 = l.getX - x, l.getZ - z, l.getY - y
    x1, ns = dirify(x1, 'N', 'S')
    z1, ew = dirify(z1, 'E', 'W')
    y1, ud = dirify(y1, 'D', 'U')
    pos = pos_string(x, y, z)
    format("%s %s ~%0.1f voxs [%0.1f%s, %0.1f%s, %0.1f%s]", name, pos,
           distance, x1, green(ns), z1, green(ew), y1, green(ud))
  end

  def pos_string(x, y, z, *)
    format("%0.1f, %0.1f, %0.1f", x, y, z)
  end

  def direction(location)
    case location.yaw.abs
    when 0..22.5 then "W"
    when 22.5..67.5 then "NW"
    when 67.5..112.5 then "N"
    when 112.5..157.5 then "NE"
    when 157.5..202.5 then "E"
    when 202.5..247.5 then "SE"
    when 247.5..292.5 then "S"
    when 292.5..337.5 then "SW"
    when 337.5..360 then "W"
    end
  end

  def distance_from_loc(player, x, y, z)
    l = player.location
    Math.sqrt((l.getX-x)*(l.getX-x)+(l.getY-y)*(l.getY-y)+(l.getZ-z)*(l.getZ-z))
  end

  def locations(player)
    @locs ||= {}
    @locs[player.name] = {} unless @locs[player.name]
    @locs[player.name]
  end

  def location(player, name)
    return player.world.spawn_location if name == 'bind'

    player_locs = locations(player)
    raise ArgumentError.new "No player stored locations" unless player_locs

    loc = player_locs[name]
    raise ArgumentError.new "Invalid location #{name}" unless loc

    org.bukkit.Location.from_a loc
  end

  def locations_path
    @path ||= File.join getDataFolder, 'locations.data'
  end

  def load_locations
    return {} unless File.exist? locations_path
    File.open(locations_path, 'rb') { |io| @locs = Marshal.load io }
  end

  def save_locations
    File.open(locations_path, 'wb') { |io| Marshal.dump @locs, io }
  end

  def setup_tracker_thread
    @tracks = {} # All tracking locations for all players
    @track_time = @config.get_int('locs_plus.track_time', 4)

    Thread.new do # Tracker thread to display all players locs of interest
      while(true)
        sleep @track_time
        @tracks.each do |player, (name, loc)|
          player.send_message loc_string(name, player, *loc)
        end
      end
    end
  end

  def waypoint_create(player, name)
    raise ArgumentError.new "Cannot use 'bind' as name" if name == 'bind'
    locations(player)[name] = player.location.to_a
    save_locations
  end

  def waypoint_help(p)
    p.send_message "/waypoint - show all waypoints"
    p.send_message "/waypoint name|bind - show named waypoint"
    p.send_message "/waypoint create name - create waypoint for name"
    p.send_message "/waypoint remove name - remove waypoint for name"
    p.send_message "/waypoint help - display help for waypoints"
  end

  def waypoint_remove(player, name)
    locations(player).delete(name)
    save_locations
  end

  def waypoint_show(player, name)
    player.send_message loc_string(name, player, *location(player, name))
  end

  def waypoint_show_all(player)
    player.send_message "Saved waypoints (name loc):"
    locations(player).each do |name, loc|
      player.send_message loc_string(name, player, *loc)
    end
    player.send_message loc_string("bind", player, *player.world.spawn_location.to_a)
  end

  def waypoint(e, *args)
    case args.length
    when 0 then waypoint_show_all e.player
    when 1 then 
      if args[0] == 'help'
        waypoint_help e.player
      else
        waypoint_show e.player, args[0]
      end
    when 2 then
      command, arg = *args

      if command == 'create'
        waypoint_create e.player, arg
      elsif command == 'remove'
        waypoint_remove e.player, arg
      else
        e.player.send_message "Bad args: /waypoint #{args.join(' ')}"
      end
    else
      e.player.send_message "Bad args: /waypoint: #{args.join(' ')}"
    end
  rescue ArgumentError => error
    e.player.send_message "Error: #{error.message}"
  end

  def track(e, *args)
    @track_time = @config.get_int('locs_plus.track_time', 4)
    case args.length
    when 1 then
      name = args[0]
      if name  == 'stop'
        @tracks[e.player] = nil
        e.player.send_message "Tracking stopped"
      elsif name == 'help'
        track_help e.player
      else
        begin
          loc = location e.player, name
          @tracks[e.player] = [name, loc] if loc
        rescue ArgumentError => error
          e.player.send_message error.message
        end
      end
    end
  end

  def track_help(player)
    player.send_message "/track name {time} - update loc every n seconds"
    player.send_message "/track stop"
  end

  def on_enable
    @config = load_configuration

    load_locations
    command('/loc', 'display current location', nil) do |e, *args|
      l = e.player.location
      e.player.send_message "Location: #{pos_string(*l.to_a)} #{direction(l)}"
    end

    command('/waypoint', 'manage waypoints (/waypoint help)', nil) do |e, *args|
      waypoint e, *args[1..-1]
    end

    setup_tracker_thread
    command('/track', 'track waypoint_name|stop', nil) do |e, *args|
      track e, *args[1..-1]
    end
  end
end
