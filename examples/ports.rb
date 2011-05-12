purugin('Ports', 0.1) do
  def on_enable
    event(:player_interact) do |e|
      if e.right_click_block? && e.clicked_block.is?(:sign_post, :wall_sign)
        lines = e.clicked_block.state.lines
        return if lines.length < 2

        id, loc = *lines

        return if id != "Teleporter"

        player = e.player
        x, y, z = loc.split(/\s*,\s*/)
        destination = org.bukkit.Location.new player.world, x.to_i, y.to_i, z.to_i
        server.scheduler.schedule_sync_delayed_task(plugin) do 
          player.teleport destination
        end
      end
    end
  end
end
