module Purugin
  module CommandParser
    class Lexer
      EOF = Object.new
      
      include Enumerable
      
      def initialize(str)
        @string, @index = str, 0
        @stream = str.split(/\s*([\{\}\|:])\s*/).flat_map { |c| c.strip.split(/\s+/) }
      end

      def peek
        return EOF if @index >= @stream.length
        @stream[@index]
      end

      def next
        token = peek
        @index += 1
        token
      end

      def each
        while token = self.next()
          break if token == EOF
          yield token
        end
        
        yield token
      end
    end
  end
end