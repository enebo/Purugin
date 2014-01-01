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

  DIRS = ['W', 'NW', 'N', 'NE', 'E', 'SE', 'S', 'SW']

  def direction(location)
    # add 255 to shift W to beginning of int division. 450 yaw per dir.
    DIRS[(location.yaw.abs * 10 + 225).to_i / 450]
  end

  def locations(player)
    @locs ||= {}
    @locs[player.name] = {} unless @locs[player.name]
    @locs[player.name]
  end

  def location(player, name)
    return player.world.spawn_location if name == 'bind'

    player_locs = locations(player)
    return nil unless player_locs

    loc = player_locs[name]
    return nil unless loc

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
    p.msg "/waypoint - show all waypoints"
    p.msg "/waypoint name|bind - show named waypoint"
    p.msg "/waypoint create name - create waypoint for name"
    p.msg "/waypoint remove name - remove waypoint for name"
    p.msg "/waypoint help - display help for waypoints"
  end

  def waypoint_remove(player, name)
    locations(player).delete(name)
    save_locations
  end

  def waypoint_show(player, name)
    player.msg loc_string(name, player, *location(player, name))
  end

  def waypoint_show_all(me)
    me.msg colorize(WAYPOINT_SHOW_ALL_HEADER)
    locations(me).each do |name, loc|
      me.msg loc_string(name, me, *loc)
    end
    me.msg loc_string("bind", me, *me.world.spawn_location.to_a)
  end

  def track(me, waypoint_name)
    me.msg "You start tracking '#{waypoint_name}'"
    @tracks[me] = [waypoint_name, location(me, waypoint_name)] 
  end

  def track_help(me)
    me.msg "/track name", "/track stop"
  end

  def track_stop(me)
    @tracks.delete(me)
    me.msg "Tracking stopped"
  end

  def track_status(me)
    if @tracks[me]
      me.msg "You are tracking to waypoint '#{@tracks[me][0]}'"
    else
      me.msg "You are not tracking anything"
    end
  end

  def on_enable
    load_locations
    public_player_command('loc', 'display current location') do |me, *|
      loc = me.location
      me.msg "Location: #{pos_string(*loc.to_a)} #{direction(loc)}"
    end

    command_type('valid_wp') do |me, waypoint_name|
      loc = location(me, waypoint_name)
      error? loc, "No such waypoint: '#{waypoint_name}'"
      waypoint_name
    end

    public_player_command('waypoint', 'manage waypoints', 
       '<show_all> | help | create {name} | remove {name:valid_wp} | <show> {name:valid_wp} ')

    setup_tracker_thread
    public_player_command('track', 'track to a waypoint', 
         '<status> | help | stop | {waypoint:valid_wp}')
  end
end
