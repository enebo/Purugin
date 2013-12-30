module Purugin
  module PlayerStorage
    ##
    # Retrieve player specific storage for the requested user.  Note that this
    # will create a store only for the module which includes it.  It is not
    # global storage.  The storage itself is a Ruby hash.
    #
    # storage_for(event.player)[:hunger] = true
    # storage_for(event.player).fetch(:hunger, false)
    #
    def storage_for(me)
      @players_storage = Hash.new { |hash, key| hash[key] = {} } unless @players_storage
      @players_storage[me.name]
    end
  end
end
