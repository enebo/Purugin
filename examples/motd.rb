class MOTDPlugin
  include Purugin::Plugin, Purugin::Colors
  description 'Message of the day', 0.4
  
  def display_motd(me)
    me.msg "Message of the Day:"
    @motd.split(/\n/).each { |line| me.msg line }
  end
  
  def make_motd_from_cli(*args)
    colorize_string args.join(" ").split("#").join("\n")
  end

  def on_enable
    config = load_configuration
    @motd = config.get_string("motd.message", "Welcome!")
    
    event(:player_join) { |e| display_motd(e.player) }
    
    public_command('motd', 'Set message of the day', '/motd line1#line2#...') do |me, *args|
      @motd = config.set! "motd.message", make_motd_from_cli(*args) if args.length > 0
      display_motd me
    end
  end
end
