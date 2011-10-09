module Purugin
  class ChangeListener
    def plugin_manager
      @main.plugin_manager
    end

    def plugin_for(path)
      $plugins[path][0]
    end

    def initialize(main, glob)
      @main, @glob = main, glob
    end

    def listen(poll_time = 2)
      loop do
        Dir[@glob].each do |relative_path|
          path = File.expand_path relative_path
          plugin, mtime = $plugins[path]

          if !plugin
            start_plugin path
          elsif mtime < File.mtime(path)
            restart_plugin path
          end
        end

        sleep poll_time
      end
    end

    def load_plugin(path)
      plugin_manager.load_plugin java.io.File.new(path)
      load path
      @main.instantiate_plugin path
    end

    def disable_plugin(path)
      plugin = plugin_for(path)
      if plugin && plugin.enabled?
        plugin_manager.disablePlugin plugin 
        # Hack around lack of unregistering
        begin
          plugin_manager.unregister_events_for plugin #if plugin_manager.respond_to? :unregister_events_for
        rescue
          puts "Who #{$!}"
        end
      end
    end

    def enable_plugin(path)
      plugin = plugin_for(path)
      plugin_manager.enablePlugin plugin if plugin && !plugin.enabled?
    end

    # Isolate starting in a thread to not stop the world
    def restart_plugin(path)
      Thread.new do
        begin
          disable_plugin path
          load path # HEH...danger is my middle name
          enable_plugin path
          $plugins[path][1] = File.mtime(path)
        rescue
          puts "Problem restarting #{path}: #{$!}"          
        end
      end
    end

    # Isolate starting in a thread to not stop the world
    def start_plugin(path)
      Thread.new do
        begin
          load_plugin path
          enable_plugin path
        rescue
          puts "Problem starting #{path}: #{$!}"          
        end
      end
    end
  end
end
