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
      attr_reader :plugin_name
      
      def initialize(name, perm, desc, usage, plugin_name, code)
        super(name, desc, usage, [])
        set_permission perm if perm
        @plugin_name, @code = plugin_name, code
      end
      
      def execute(sender, command_label, args)
        @code.call sender, *args
        true
      rescue CommandError => ce
        sender.msg red("#{name}: #{ce.message}")
        sender.msg red(usage)
        false
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
    # * _usage_ - usage string to be displayed on error
    # * _perm_ - permission name to check against
    # * _code_ - block supplied which is the logic for the command
    # === Example
    # command('/die', 'End it all...you are stuck') do |e, *args|
    #   e.player.health = 0
    # end
    #    
    def command(name, desc, usage="/#{name}", perm="#{basename}.#{name[1..-1]}", &code)
      plugin_name = getDescription.name.downcase
      plugin_manager.add_command CMD.new(name, perm, desc, usage, plugin_name, code)
    end
    
    # Create a command that can be executed by any user (same as 
    # as command() but no perm parameter.
    def public_command(name, desc, usage="/#{name}", &code)
      command(name, desc, usage, nil, &code)
    end
  end
end

