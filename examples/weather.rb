class WeatherPlugin
  include Purugin::Plugin, Purugin::Colors
  description 'Weather', 0.5
  
  def display_storm_conditions(me, world)
    conditions = world.storming? ? 'storms': 'clear skies'
    timeframe = !@weather ? '[weather disabled]' : "for #{world.weather_duration / 10}s"
    me.msg "weather: #{conditions} #{timeframe}"
  end
  
  def on_enable
    config = load_configuration
    @weather = config.get_boolean('weather.storms', true)

    public_command('weather', 'toggle weather', '/weather stop|start? world?') do |me, *args|
      # Console or explicit world provided
      if !me.player? || args.length > 1
        world = error? me.server.get_world(args[1].to_s), "Missing/bad world name"
      else
        world = me.world
      end

      if args.empty?
        display_storm_conditions me, world
      elsif args[0] == 'stop'
        world.storm = world.thundering = false
        me.msg "weather: storm stopped"
      elsif args[0] == 'start'
        if @weather
          world.storm = true
          me.msg "weather: storm started"
        else
          abort! "weather: no can do..weather disabled"
        end
      elsif args[0] == 'disable'
        @weather = config.set! 'weather.storms', false
        me.msg "weather: disabled"
      elsif args[0] == 'enable'
        @weather = config.set! 'weather.storms', true
        me.msg "weather: enabled"
      else
        me.msg red("weather: invalid arg #{args[0]}")
      end
    end

    event(:weather_change, :highest) do |e| 
      e.cancelled = true if !@weather && e.to_weather_state
    end
    event(:thunder_change, :highest) do |e|
      e.cancelled = true if !@weather && e.to_thunder_state 
    end
    event(:lightning_strike, :highest) { |e| e.cancelled = true }
    event(:world_load, :monitor) do |e|
      unless @weather
        server.worlds.each do |world|
          world.storm = false if world.storming?
          world.thundering = false if world.thundering?
        end
      end
    end
  end
end
