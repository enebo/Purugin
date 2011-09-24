class PausePlugin
  include Purugin::Plugin
  description 'Pause', 0.1
  
  def on_enable
    public_command('p', 'sleep and make all mobiles stop', '/p time?') do |me, *args|
      if args.length > 0
        time = error? args[0].to_f, "Must specify a name"
      else
        time = 25
      end
      me.msg "Pausing the action for #{time}s"
      sleep time
    end
  end
end
