class WhoPlugin
  include Purugin::Plugin
  description 'Who', 0.4
  
  def on_enable
    public_command('who', 'display all users') do |me, *|
      me.world.players.each do |player|
        me.msg "#{player.display_name} (#{player.name})"
      end
    end
  end
end
