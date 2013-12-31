module Purugin
  module CommandParser
    module Syntax
      class Type
        attr_reader :name, :constraints
      
        def initialize(name)
          @name = name
          @constraints = []
        end
      
        def ==(other)
          @name == other.name && @constraints == other.constraints
        end
      end
    end
  end
end
