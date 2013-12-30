module Purugin
  module CommandParser
    module Syntax
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
            when '*'
              @arity = MULTIPLE_ARGS 
              @method_suffix += "_star"
              @bareword_slots << nil
            when Purugin::CommandParser::Syntax::Variable
              @bareword_slots << nil
            else
              # FIXME: Invalid syntax possible..error now or later?
              @method_suffix += "_#{word}"
              @bareword_slots << word
            end
          end
        end
      end
    end
  end
end
