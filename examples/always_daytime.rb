class AlwaysDaytimePlugin
  include Purugin::Plugin, Purugin::Colors, Purugin::Tasks
  description 'A world that is never dark', 0.1
  
  def on_enable
    sync_task(0, 20) do
      server.worlds.each do |world|
        time = world.time
        relative_time = time % 24_000
        world.time = 1_000 if relative_time > 11_500
      end
    end
  end
end
