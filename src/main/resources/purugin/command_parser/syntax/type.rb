module Purugin
  module CommandParser
    module Syntax
      class Type
        attr_reader :value, :constraints
      
        def initialize(value)
          @value = value
          @constraints = []
        end
      
        def ==(other)
          value == other.value && constraints == other.constraints
        end
      end
    end
  end
end
