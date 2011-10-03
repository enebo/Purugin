module Purugin
  class ChangeListener
    def initialize(main, glob)
      @main, @glob = main, glob
    end

    def listen(poll_time = 2)
      loop do
        Dir[@glob].each do |relative_path|
          path = File.expand_path relative_path
          plugin, mtime = $plugins[path]

          if !plugin
            load_plugin path
          elsif mtime < File.mtime(path)
            update_plugin path
          end
        end

        sleep poll_time
      end
    end

    def load_plugin(path)
      @main.console "New Plugin to be loaded: #{path}"
      require path
      @main.instantiate_plugin path
    end

    def update_plugin(path)
      @main.console "Modified plugin: #{path}"
    end
  end
end
