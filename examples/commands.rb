require 'purugin/colors'

class CommandsPlugin
  include Purugin::Plugin, Purugin::Colors
  description 'Commands', 0.4
  attr_reader :commands

  module Command
    class CommandError < Exception
      attr_reader :cause
      def initialize(message, cause=nil)
        super(message)
        @cause = cause
      end
    end
    class CMD < Struct.new(:permission, :description, :plugin_name, :code)
      def runnable_by?(player)
        !permission || player.permission?(permission)
      end
    end

    def basename
      @basename ||= "purugin.#{getDescription.name.downcase}"
    end
    
    # If condition is false,nil, or an exception break out of command and display error message.
    # returns the result of the condition otherwise
    def error?(condition, message)
      raise CommandError.new message unless condition
      condition
    rescue
      raise CommandError.new message, $!
    end

    # Create a command which will respond to /name.
    # 
    # === Parameters
    # * _name_ - of the command (e.g. "/nick")
    # * _desc_ - description for this command
    # * _perm_ - permission name to check against
    # * _code_ - block supplied which is the logic for the command
    # === Example
    # command('/die', 'End it all...you are stuck') do |e, *args|
    #   e.player.health = 0
    # end
    #    
    def command(name, desc, perm="#{basename}.#{name[1..-1]}", &code)
      commander = plugin_manager['Commands']
      
      if commander
        plugin_name = getDescription.name.downcase
        commander.commands[name] = CMD.new perm, desc, plugin_name, code
      else
        puts "No commands plugin to register: #{name}. Skipping..."
      end
    end
    
    # Create a command that can be executed by any user (same as 
    # as command() but no perm parameter.
    def public_command(name, desc, &code)
      command(name, desc, nil, &code)
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
        cmd.code.call(e, *args) if cmd && cmd.runnable_by?(e.player)
      rescue CommandError => ce
        e.player.send_message red("#{name}: #{ce.message}")
      end
    end
  end
end
