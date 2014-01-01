module Purugin
  module CommandParser
    module Syntax
      class Command
        MULTIPLE_ARGS = -1;
        attr_reader :words, :method_suffix, :arity
        attr_accessor :name

        def initialize(*words)
          @words = words
        end

        # Add a variable or bare word to this command.
        def <<(word)
          @words << word
        end
      
        def ==(other)
          @words == other.words
        end

        ##
        # Returns args array to pass to method if it is a match otherwise nil.
        def matches(args, sender, type_registry)
          return args if @arity == MULTIPLE_ARGS
          return nil if args.length != @arity
          process_arguments(args, sender, type_registry)
        end

        # Make sure each argument matches the commands format.  bare words must be present in
        # *args and each variable which is typed must also conform to that type.  Return
        # an new argument array destined to the intended command method.
        def process_arguments(args, sender, type_registry)
          variables = []
          @bareword_slots.each_with_index do |bareword, i|
            if bareword                  # Bare words must match all incoming arguments or fail.
              return nil if args[i] != bareword  
            elsif @words[i].type         # This is a typed variable (apply type converter).
              variables << process_typed_argument(args, i, sender, type_registry)
            else                         # Untyped-variable. 
              variables << args[i]
            end
          end

          variables
        end

        def process_typed_argument(args, i, sender, type_registry)
          type_name = @words[i].type.name
          converter = type_registry[type_name]

          raise ArgumentError.new "Cannot find converter for: '#{type_name}'" unless converter
          
          converter.call(sender, args[i])          
        end
        
        # Build up a method suffix of where this command should dispatch too when called
        # with the proper syntax.  Also calculate which indexes bare words are located in the 
        # incoming args array.  Lastly calculate arity for faster processing and detection of
        # varargs.
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
          @method_suffix = "_#{name}" if name # If name specified for command use that.
        end
      end
    end
  end
end
