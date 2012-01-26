require 'purugin/util'

module Purugin
  module Predicate
    include Purugin::StringUtils
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
  end
end
