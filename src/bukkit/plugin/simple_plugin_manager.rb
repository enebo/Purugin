require 'java'

class org::bukkit::plugin::SimplePluginManager
  # Hack: No exposure to commandMap and I don't want to hack in new plugin manager type
  field_reader :commandMap => :command_map
  
#  field_reader :listeners
  
  # We either register a new command of infect the existing one with the
  # new commands state if the command has already been registered.
  def add_command(command, prefix="purugin")
    old_command = command_map.get_command(command.name)
    if old_command
      command.infect(old_command)
    else
      command_map.register prefix, command
    end
  end

  # Hack to unregister all events for a particular plugin
  def unregister_events_for(plugin)
#    listeners.values.each do |type_set|
#      type_set.to_a.each do |item|
#        if item.plugin == plugin
#          type_set.remove item 
#        end
#      end
#    end
  end
end
