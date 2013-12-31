module Purugin
  module CommandParser
    class CommandTypeRegistry
      def initialize
        @types = {} # name, lambda
        
        register_builtins
      end
      
      def [](name)
        @types[name]
      end
      
      def []=(name, proc)
        @types[name] = proc
      end
      
      def register_builtins
        @types['noop'] = proc { |sender, value| value }
        
        self['entity'] = proc do |sender, value|
          org.bukkit.entity.EntityType.from_name(value.to_s).tap do |entity|
            Purugin::Command::error? entity, "No such entity: #{value.to_s}"
          end
        end
        
        self['byte'] = proc do |sender, value| 
          value.to_i.tap do |ivalue|
            Purugin::Command::error? ivalue >= 0, "Value must be positive: #{value}"
            Purugin::Command::error? ivalue < 127, "Value must be <127: #{value}"
          end
        end
      end
    end
  end
end
