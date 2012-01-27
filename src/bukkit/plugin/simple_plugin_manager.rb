require 'java'

class org::bukkit::plugin::SimplePluginManager
  # Hack: No exposure to commandMap and I don't want to hack in new plugin manager type
  field_reader :commandMap => :command_map
  
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
end
