class LocsPlus
  include Purugin::Plugin, Purugin::Colors, Purugin::Tasks
  description 'LocsPlus', 0.5

  WAYPOINT_SHOW_ALL_HEADER = "Saved waypoints ({blue}name {gray}loc{white} distance {green}ns ew up{white}):"
  
  module CoordinateEncoding
    def encode(value)
      (value.to_i + 32000).to_s(36)
    end
  
    def decode(value)
      value.to_i(36) - 32000
    end
  end
  
  include CoordinateEncoding
  
  # Takes distance and applies proper direction label
  def distance_string(distance, positive, negative)
    "%0.1f%s" % [distance.abs, green(distance < 0 ? negative : positive)]
  end  

  def loc_string(name, player, x, y, z, pitch, yaw)
    loc = player.location
    dx, dy, dz = loc.x - x, loc.y - y, loc.z - z
    distance = Math.sqrt(dx ** 2 + dy ** 2 + dz ** 2)
    ns = distance_string(dx, 'N', 'S')
    ew = distance_string(dz, 'E', 'W')
    ud = distance_string(dz, 'D', 'U')
    colorize("{blue}%s {gray}[%s]{white} ~%0.1f voxs [%s, %s, %s]" % 
             [name, pos_string(x, y, z), distance, ns, ew, ud])
  end

  def pos_string(x, y, z, *)
    "%s, %s, %s" % [encode(x), encode(y), encode(z)]
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
    tracks = @tracks = {} # All tracking locations for all players
    @track_time = config.get_fixnum!('locs_plus.track_time', 4)

    # Tracker thread to display all players locs of interest
    sync_task(0, @track_time) do
      tracks.each do |player, (name, loc)|
        player.msg loc_string(name, player, *loc)
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
    player.msg colorize(WAYPOINT_SHOW_ALL_HEADER)
    locations(player).each do |name, loc|
      player.send_message loc_string(name, player, *loc)
    end
    player.send_message loc_string("bind", player, *player.world.spawn_location.to_a)
  end

  def waypoint(sender, arg=nil)
    if arg
      waypoint_show sender, arg
    else
      waypoint_show_all sender
    end
  end

  def waypoint_error(sender, *args)
    sender.msg red("Bad args: /waypoint: #{args.join(' ')}")
  end

  def track(sender, waypoint_name = nil)
    if waypoint_name
      sender.msg "You start tracking '#{waypoint_name}'"
      @tracks[sender] = [waypoint_name, location(sender, waypoint_name)] 
    elsif @tracks[sender]
      sender.msg "You are tracking to waypoint '#{@tracks[sender][0]}'"
    else
      sender.msg "You are not tracking anything"
    end
  end

  def track_help(me)
    me.msg "/track name {time} - update loc every n seconds"
    me.msg "/track stop"
  end

  def track_stop(sender)
    @tracks.delete(sender)
    sender.msg "Tracking stopped"
  end

  def track_error(sender, *args)
    sender.msg "Track error: #{args}"
  end

  def on_enable
    load_locations
    public_player_command('loc', 'display current location') do |me, *|
      loc = me.location
      me.msg "Location: #{pos_string(*loc.to_a)} #{direction(loc)}"
    end

    command_type('valid_waypoint') do |sender, waypoint_name|
      loc = location(sender, waypoint_name)
      error? loc, "No such waypoint: '#{waypoint_name}'"
      waypoint_name
    end

    public_command!('waypoint', 'manage waypoints', 
       '| {name} | help | create {name} | remove {name:valid_waypoint}')

    setup_tracker_thread
    public_command!('track', 'track to a waypoint', 
       '| help | stop | {waypoint:valid_waypoint}')
  end
end

