require 'purugin/util'

module Purugin
  module Predicate
    include Purugin::StringUtils
    ##
    # Define a method called name on this class which returns false
    # and then define a method on true_class which returns true
    # === Examples
    # Class Entity
    #   extend Purugin::Predicate
    #   
    #   # defines living? method on Entity and Living
    #   predicate :living, Living 
    # end
    def predicate(true_class, name=nil)
      name = name ? name.to_s : true_class.name.split('::')[-1]
      label = Purugin::StringUtils.camelcase_to(name, ' ')
      name = Purugin::StringUtils.camelcase_to(name, '_').downcase
      true_class.__send__(:define_method, :kind) { name }
      true_class.__send__(:define_method, :name) { label }
      define_method(name + '?') { false }
      true_class.send(:define_method, name + '?') { true }
    end
    
    ##
    # Define three methods on every enum value and one generic is? method:
    # kind - A symbol returning method (DESERT_HILLS.kind #> :desert_hills)
    # name - A nice printable string representation (DESERT_HILLS.name #> "Desert Hills")
    # individual predicates: (desert_hills? in DESERT_HILLS)
    # is?(kind_value) 
    def enum_predicates(enum=self)
      # Define a kind and name method for each biome enum
      enum.values.each do |e|
        kind = e.name.downcase
        name = kind.split('_').map(&:capitalize).join(' ')
        
        # Define a false on base class so all enums can respond to all individual predicate methods
        enum.__send__(:define_method, kind + '?') { false }

        # Define methods on each instance which return appropriate values for each individual enum
        e.instance_eval <<-EOS
          def kind; :#{kind}; end
          def name; '#{name}'; end
          def #{kind}?; :#{kind} == kind; end
        EOS
      end
      
      ##
      # Is this biome we think it is?
      # === Examples
      # iron_block.biome.is? :rainforest # true if this iron is found in a rain forest
      #
      enum.__send__(:define_method, :is?) do |value|
        value.to_s == kind.to_s
      end
    end
  end
end
