module Purugin
  module CommandParser
    module Syntax
      class Variable
        attr_reader :value
        attr_accessor :type

        def initialize(value)
          @value = value
        end
      
        def ==(other)
          other.class == self.class && value == other.value && type == other.type
        end
      end      
    end
  end
end
