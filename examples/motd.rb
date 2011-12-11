class MOTDPlugin
  include Purugin::Plugin, Purugin::Colors
  description 'Message of the day', 0.5
  
  def display_motd(me)
    me.msg "Message of the Day:"
    @motd.each_line { |line| me.msg line }
  end
  
  def make_motd_from_cli(*args)
    colorize_string args.join(" ").split("#").join("\n")
  end

  def on_enable
    @motd = config.get! "motd.message", "Welcome!"
    
    event(:player_join) { |e| display_motd(e.player) }
    
    public_command('motd', 'Message of the day', '/motd line1#line2#...') do |me, *args|
      if args.length > 0
        @motd = config.set! "motd.message", make_motd_from_cli(*args) 
      end
      display_motd me
    end
  end
end