module Purugin
  ##
  # Useful routines for converting arguments and ensuring proper ordering of various arity call
  # sequences.  So much type-checking might seem un-Rubylike but these methods are only intended
  # for use as preprocessors before sending them into a statically-typed Java land.  You would
  # much rather have these errors than the Java API ones.
  # 
  module ConversionUtils
    ##
    # Try to coerce to an Integer.  If it fails to become an Integer or nil then it will raise
    # a useful Argument error.
    def convert_to_int(label, value)
      convert_to_type(label, Integer, :to_int, value)
    end
    
    ##
    # Try to coerce to a Material.  If it fails to become an Material or nil then it will raise
    # a useful Argument error.
    def convert_to_material(label, value)
      convert_to_type(label, org.bukkit.Material, :to_material, value)      
    end
    
    def convert_to_type(label, type, conversion_method, value)
      return value unless value
      value = value.__send__(conversion_method)if value.respond_to?(conversion_method)
      raise ArgumentError.new("#{label} must be an integer: #{value}") unless value.kind_of? type
      value
    end
    
    ##
    #
    def scan_args(required, optional, *args)
      arity = required.keys.length + optional.keys.length
      
      raise ArgumentError.new("Too many arguments passed. #{args.length} for #{arity}") if args.length > arity
      
      keys = required.keys
      values = required.values
      0.upto(required.length-1) do |i|
        args[i] = __send__(values[i], keys[i], args[i]) if values[i]
        raise ArgumentError.new("nil argument found for required arg #{keys[i]}") if !args[i]
      end

      values = optional.values
      first_nil = nil
      keys.length.upto(arity) do |i|
        args[i] = __send__(values[i], keys[i], args[i]) if values[i]        
        if !args[i]
          first_nil = i
          break
        end
      end
      
      return args if !first_nil
      
      first_nil.upto(arity) do |i|
        raise ArgumentError.new("Have non-nil argument after nil argument for arg #{optional.keys[first_nil-keys.length]}") if args[i]
      end
      
      args[0...first_nil]
    end
  end
end
