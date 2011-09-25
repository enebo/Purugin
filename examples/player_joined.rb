class PlayerJoinedPlugin
  include Purugin::Plugin
  description 'PlayerJoined', 0.2
  
  def on_enable
    event(:player_join) do |e|
      e.player.world.players.each do |p| 
        p.msg "Player #{e.player.name} has joined"
      end
    end

    event(:player_quit) do |e|
      e.player.world.players.each do |p| 
        p.msg "Player #{e.player.name} has quit"
      end
    end
  end
end
