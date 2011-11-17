module Purugin
  module Predicate
    # Define a method called name on this class which returns false
    # and then define a method on true_class which returns true
    # === Examples
    # Class Entity
    #   extend Purugin::Predicate
    #   
    #   # defines living? method on Entity and Living
    #   predicate :living, Living 
    # end
    def predicate(name, true_class)
      name = name.to_s + "?"
      define_method(name) { false }
      true_class.send(:define_method, name) { true }
    end
  end
end
