require 'purugin/command_parser/syntax/command'
require 'purugin/command_parser/syntax/type'
require 'purugin/command_parser/syntax/variable'
require 'purugin/command_parser/lexer'
require 'purugin/command_parser/parser_error'

module Purugin
  module CommandParser
    class Parser
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
      # player_command('egg_spawn', 'type of egg', '{mob:entity}'
      # 
      # 1. dispatches to egg_spawn() with a single argument of mob which is type-checked to be an
      # entity.
      # 
      # Types to support: creature, block, boolean, integer, float, color
      #
      def self.parse(str)
        lexer = Lexer.new(str)
        
        # Special-case: syntax string is just ''.
        return [Purugin::CommandParser::Syntax::Command.new] if lexer.peek == Purugin::CommandParser::Lexer::EOF
        
        [].tap do |commands|
          while command = parse_command(lexer)
            command.post_process
            commands << command
          end
        end
      end

      def self.parse_command(lexer)
        return nil if lexer.peek == Purugin::CommandParser::Lexer::EOF
        
        Purugin::CommandParser::Syntax::Command.new.tap do |command|
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
        Purugin::CommandParser::Syntax::Variable.new(parse_bareword(lexer)).tap do |variable|
          token = lexer.next
          
          if token == ':' # Type separator
            variable.type = Purugin::CommandParser::Syntax::Type.new parse_bareword(lexer)
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
        
        token == '|' || token == Purugin::CommandParser::Lexer::EOF
      end
      
      def self.verify?(expected, actual, test)
        raise ParserError.new "#{expected} expected but got: '#{actual}'" if test
      end
    end
  end
end