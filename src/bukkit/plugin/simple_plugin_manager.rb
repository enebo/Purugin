require 'java'

class org::bukkit::plugin::SimplePluginManager
  # Hack: No exposure to commandMap and I don't want to hack in new plugin manager type
  field_reader :commandMap => :command_map
  
  def add_command(command, prefix="purugin")
    command_map.register prefix, command
  end
end
