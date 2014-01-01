require 'purugin/command_parser/parser'
require 'purugin/command_parser/command_type_registry'

module Purugin
  module Command
    class CommandError < Exception
      attr_reader :cause
      def initialize(message, cause=nil)
        super(message)
        @cause = cause
      end
    end
    
    class CMD < org::bukkit::command::Command
      include Purugin::Colors
      attr_accessor :plugin_name, :style, :code
      
      # === Parameters
      # * _style_ - :all, :player, :console
      def initialize(name, perm, desc, usage, plugin_name, style, code)
        super(name, desc, usage, [])
        set_permission perm if perm
        @plugin_name, @style, @code = plugin_name, style, code
      end

      # FIXME: Bukkit command registry does not allow removing commands
      # without removing every single one.  This hacks around it by 
      # allowing us to transfer state of our new command into the last
      # registered version.  On top of being a hack there is a certain
      # amount of danger since we do not lock the command in mid-flight,
      # but it may be a minor danger since only the code var should truly
      # bone us and that race should be SAFE in JRuby.
      def infect(other)
        other.plugin_name = plugin_name
        other.style = style
        other.permission = permission if permission
        other.code = code
      end
      
      # FIXME: return values and make sure this is easy from commands
      def execute(sender, command_label, args)
        what = sender.player? ? :player : :console
        
        if (@style == :all || @style == what) && permitted?(sender)
          @code.call sender, *args
        elsif @style == :player && what == :console
          sender.msg red("#{name}: will not work from the console")
          false
        end
        true
      rescue CommandError => ce
        sender.msg red("#{name}: #{ce.message}")
        sender.msg red(usage)
        false
      end
    end

    def basename
      @basename ||= getDescription.name.downcase
    end
    
    # Specify that you are done executing this command due to something that went
    # wrong.  You can send a message to display an error.
    # === Parameters
    # * _message_ to display on abort
    # === Example
    # abort! "You suck"
    #
    def abort!(message)
      raise CommandError.new message
    end
    module_function :abort!
    
    # If condition is false,nil, or an exception break out of command and display error message.
    # returns the result of the condition otherwise
    # === Parameter
    # * _condition_ to check for truthiness
    # * _message_ to print out if _condition_ is not true
    # === Example
    # error? i > 3, "'i' is not greater than 3"
    def error?(condition, message)
      raise CommandError.new message unless condition
      condition
    rescue
      raise CommandError.new message, $!
    end
    module_function :error?

    # Create a command which will respond to /name.
    # 
    # === Parameters
    # * _name_ - of the command (e.g. "/nick")
    # * _desc_ - description for this command
    # * _usage_ - usage string to be displayed on error
    # * _perm_ - permission name to check against
    # * _code_ - block supplied which is the logic for the command
    # === Example
    # command('/die', 'End it all...you are stuck') do |e, *args|
    #   e.player.health = 0
    # end
    #    
    def command(name, desc, usage="/#{name}", perm="#{basename}.#{name}", style=:all, &code)
      code = syntax_generated_command(name, usage) unless block_given?
      plugin_name = getDescription.name.downcase
      plugin_manager.add_command CMD.new(name, perm, desc, usage, plugin_name, style, code)
    end
    
    # Create a command that can be executed by permitted users and
    # will give a friendly error message for console users.
    def player_command(name, desc, usage="/#{name}", perm="#{basename}.#{name}", &code)
      command(name, desc, usage, perm, :player, &code)
    end
    
    # Create a command that can be executed by the console only.
    # Players will not know of its existence.
    def console_command(name, desc, usage="/#{name}", perm="#{basename}.#{name}", &code)
      command(name, desc, usage, perm, :console, &code)
    end    
    
    # Create a command that can be executed by any user or from 
    # the console (Usage same as as command() but no perm parameter).
    def public_command(name, desc, usage="/#{name}", &code)
      command(name, desc, usage, nil, &code)
    end
    
    # Create a command that can be executed by any user but if 
    # executed from the console, the console will get a friendly
    # error message (Usage same as as command() but no perm parameter).
    def public_player_command(name, desc, usage="/#{name}", &code)
      command(name, desc, usage, nil, :player, &code)      
    end

    def syntax_generated_command(name, syntax)
      commands = Purugin::CommandParser::Parser.parse(syntax)
       lambda do |sender, *args|
        match = false
        commands.each do |command|
          if new_args = command.matches(args, sender, @type_registry)
            match = true
            send "#{name}#{command.method_suffix}", sender, *new_args
            break
          end
        end
        
        unless match
          if respond_to? "#{name}_error"
            send "#{name}_error", sender, *args 
          else
            sender.msg "Invalid command: /#{name} #{args.join(' ')}"
            sender.msg "Syntax: #{syntax}"
          end
        end
      end
    end
    
    def command_type(name, &code)
      @type_registry[name] = code
    end
  end
end

