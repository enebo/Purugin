class CommandsPlugin
  include Purugin::Plugin
  description 'Commands', 0.1

  attr_reader :commands

  module Command
    class CMD < Struct.new(:permission, :description, :plugin_name, :code)
    end

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

  def initialize(*a)
    super
    @commands = {}
  end

  java_import org.bukkit.ChatColor

  def on_enable
    @permissions = plugin_manager['Permissions']

    puts "No permissions...free for all" unless @permissions

    command('/help', 'help on all commands', nil) do |e, *args|
      player = e.player
      @commands.sort.each do |command, entry|
        permission = has_permission(player, entry.permission) ? 
          ChatColor::GREEN : ChatColor::RED
        e.player.send_message "#{command} - #{entry.description} [#{entry.plugin_name}]#{permission}*"
      end
    end

    event(:player_command_preprocess) do |e|
      player = e.player
      command, *args = e.message.split(/\s+/)
      entry = @commands[command]

      if entry
        if has_permission(e.player, entry.permission)
          entry.code.call(e, command, *args)
        else
          e.player.send_message "Insufficient privelege for:  #{command}"
        end
      else
        e.player.send_message "Uknown command: #{command}"
      end
    end
  end

  def has_permission(player, permission)
    !@permissions || !permission || 
      @permissions.handler.has(player, permission) ||
      @permissions.handler.has(player, basename)
  end
end
