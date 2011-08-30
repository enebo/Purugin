require 'purugin/colors'

class CommandsPlugin
  include Purugin::Plugin, Purugin::Colors
  description 'Commands', 0.2
  attr_reader :commands
  optional :Permissions

  module Command
    class CMD < Struct.new(:permission, :description, :plugin_name, :code); end

    def basename
      @basename ||= "purugin.#{getDescription.name.downcase}"
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
    puts "No permissions...free for all" unless Permissions()

    command('/help', 'help on all commands', nil) do |e, *args|
      @commands.sort.each do |name, cmd|
        allowed = permitted?(e.player, cmd.permission) ? green('*') : red('*')
        e.player.msg "#{name} - #{cmd.description} [#{cmd.plugin_name}]#{allowed}"
      end
    end

    event(:player_command_preprocess) do |e|
      name, *args = e.message.split(/\s+/)
      cmd = @commands[name]

      if cmd
        if permitted? e.player, cmd.permission
          cmd.code.call(e, name, *args)
        end
      end
    end
  end

  def permitted?(player, permission)
    !Permissions() || !permission || Permissions().handler.has(player, permission)
  end
end
