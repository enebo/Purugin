#
# This example we have 5 different syntaxes for the command (we will use
# waypoint as actual command name for the example):
# '| {name} | help | create {name} | remove {name}'
#
# 1. '' (before first '|') dispatch to waypoint(issuer)
# 2. '{name}' dispatch to waypoint(issuer, name)
# 3. 'help' dispatch to waypoint_help(issuer)
# 4. 'create {name}' to waypoint_create(issuer, name)
# 5. 'remove {name}' to waypoint_remove(issuer, name)
#
# The above syntax allows a large amount of commands to be modelled.  One
# additional feature of the grammar is the use of a trailing wildcard
# (we will use execute as the name of this command):
#
# 'help | *'
#
# 1. 'help' dispatch to command_help(issuer)
# 2. '*' dispatch to command_star(issuer, *rest)
# 
# player_command('egg_count', '# of spawns.', '{number:integer[0-127]}')
# 
# 1. ':' specifies type constaint, and 0-127 specifies the range qualifier. dispatches to egg_count
# 
# player_command('egg_spawn', 'type of egg', '{mob:creature}'
# 
# Types to support: creature, block, boolean, integer, float, color
# 
# TODO: Incrementally add type specifier and then range constraints
# TODO: Add framework for defining and registering types and constraints so people can make their own
#
# This impl is pretty ugly... :)
module Purugin
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
    
    Star = '*'

    class Command
      MULTIPLE_ARGS = -1;
      attr_reader :words, :method_suffix

      def initialize(*words)
        @words = words
      end

      def <<(word)
        @words << word
      end
      
      def ==(other)
        words == other.words
      end

      ##
      # Returns args to pass to method if it is a match otherwise nil.
      def matches(args)
        return args if @arity == MULTIPLE_ARGS
        return nil if args.length != @arity

        barewords_matches(args)
      end

      def barewords_matches(args)
        variables = []
        @bareword_slots.each_with_index do |bareword, i|
          if bareword
            return nil if args[i] != bareword  
          else
            variables << args[i]
          end
        end

        variables
      end

      def post_process
        @method_suffix = ""
        @arity = @words.length
        @bareword_slots = []
        @words.each_with_index do |word|
          case word
          when Purugin::Syntax::Star
            @arity = MULTIPLE_ARGS 
            @method_suffix += "_star"
            @bareword_slots << nil
          when Purugin::Syntax::Variable
            @bareword_slots << nil
          when Purugin::Syntax::Bareword
            # FIXME: Invalid syntax possible..error now or later?
            @method_suffix += "_#{word.value}"
            @bareword_slots << word.value
          end
        end
      end
    end

    class ParserError < StandardError
    end

    EOF = Object.new
    
    class Lexer
      include Enumerable
      
      def initialize(str)
        @string, @index = str, 0
        @stream = str.split(/\s*([\{\}\|:])\s*/).flat_map { |c| c.strip.split(/\s+/) }
      end

      def peek
        return Purugin::Syntax::EOF if @index >= @stream.length
        @stream[@index]
      end

      def next
        token = peek
        @index += 1
        token
      end

      def each
        while token = self.next()
          break if token == Purugin::Syntax::EOF
          yield token
        end
        
        yield token
      end
    end
    
    class Parser
      def self.parse(str)
        lexer = Lexer.new(str)
        [].tap do |commands|
          while command = parse_command(lexer)
#            command.post_process
            commands << command
          end
        end
      end

      def self.parse_command(lexer)
        return nil if lexer.peek == Purugin::Syntax::EOF
        
        Purugin::Syntax::Command.new.tap do |command|
          loop do
            break if delimeter?(lexer)  # Empty command case
            command << parse_word(lexer)
            break if delimeter?(lexer)  # End of one or more words
          end
          lexer.next
        end
      end

      def self.parse_word(lexer)
        token = lexer.next
        token == '{' ? parse_variable(lexer) : token
      end
      
      def self.parse_variable(lexer)
        Purugin::Syntax::Variable.new(parse_bareword(lexer)).tap do |variable|
          token = lexer.next
          
          if token == ':' # Type separator
            variable.type = Purugin::Syntax::Type.new parse_bareword(lexer)
            token = lexer.next
          end
        
          verify?('}', token, token != '}')
        end
      end
      
      def self.parse_bareword(lexer)
        lexer.next.tap { |token| verify?('Bareword', token, token !~ /(\*|[a-z][a-zA-Z0-9]*)/) }
      end
      
      def self.delimeter?(lexer)
        token = lexer.peek
        
        token == '|' || token == Purugin::Syntax::EOF
      end
      
      def self.verify?(expected, actual, test)
        raise ParserError.new "#{expected} expected but got: '#{actual}'" if test
      end
    end
  end
end
