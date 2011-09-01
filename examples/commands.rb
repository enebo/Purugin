require 'purugin/colors'

class CommandsPlugin
  include Purugin::Plugin, Purugin::Colors
  description 'Commands', 0.2
  attr_reader :commands

  module Command
    class CommandError < Exception
    end
    class CMD < Struct.new(:permission, :description, :plugin_name, :code)
      def runnable_by?(player)
        !permission || player.permission?(permission)
      end
    end

    def basename
      @basename ||= "purugin.#{getDescription.name.downcase}"
    end
    
    # If condition is true break out of command and display error message
    def error(condition, message)
      raise CommandError.new message if condition
    end

    def command(name, desc, perm="#{basename}.#{name[1..-1]}", &code)
      commander = plugin_manager['Commands']
      
      if commander
        plugin_name = getDescription.name.downcase
        commander.commands[name] = CMD.new perm, desc, plugin_name, code
      else
        puts "No commands plugin to register: #{name}. Skipping..."
      end
    end
  end

  include Command

  def initialize(*)
    super
    @commands = {}
  end

  def on_enable
    command('/help', 'help on all commands', nil) do |e, *args|
      @commands.sort.each do |name, cmd|
        allowed = cmd.runnable_by?(e.player) ? green('*') : red('*')
        e.player.msg "#{name} - #{cmd.description} [#{cmd.plugin_name}]#{allowed}"
      end
    end

    event(:player_command_preprocess) do |e|
      name, *args = e.message.split(/\s+/)      
      begin
        cmd = @commands[name]
        cmd.code.call(e, name, *args) if cmd && cmd.runnable_by?(e.player)
      rescue CommandError => ce
        e.player.send_message red("#{name}: #{ce.message}")
      end
    end
  end
end
