module Purugin
  module CommandParser
    module Syntax
      class Variable
        attr_reader :name
        attr_accessor :type

        def initialize(name)
          @name = name
        end
      
        def ==(other)
          other.class == self.class && @name == other.name && @type == other.type
        end
      end
    end
  end
end
