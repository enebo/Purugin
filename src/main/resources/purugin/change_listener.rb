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
          m = org.bukkit.event.HandlerList.java_method :unregisterAll, [org.bukkit.plugin.Plugin]
          m.call(plugin)
          unregister_constants plugin.class
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
      puts "RESTARTING: #{path}"
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
      puts "STARTING: #{path}"
      Thread.new do
        begin
          load_plugin path
          enable_plugin path
        rescue
          puts "Problem starting #{path}: #{$!}"
        end
      end
    end

    # Undefine constants to eliminate warning on const redefinition
    def unregister_constants(clz)
      local_constants(clz).each do |constant|
        unregister_constants(constant) if constant.is_a? Module
        clz.send :remove_const, constant.to_s
      end
    end

    # Adapted from Activesupport (perhaps I should just make Purugin depend on 1.9 mode?)
    if RUBY_VERSION < '1.9'
      # Returns the constants that have been defined locally by this object and
      # not in an ancestor. This method is exact if running under Ruby 1.9. In
      # previous versions it may miss some constants if their definition in some
      # ancestor is identical to their definition in the receiver.
      def local_constants(clz)
        inherited = {}

        clz.ancestors.each do |anc|
          next if anc == clz
          anc.constants.each { |const| inherited[const] = anc.const_get(const) }
        end

        clz.constants.select do |const|
          !inherited.key?(const) || inherited[const].object_id != clz.const_get(const).object_id
        end
      end
    else
      def local_constants(clz) #:nodoc:
        clz.constants(false)
      end
    end
  end
end
