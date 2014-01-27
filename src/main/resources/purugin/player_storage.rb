module Purugin
  module PlayerStorage
    ##
    # Retrieve player specific storage for the requested user.  Note that this
    # will create a store only for the module which includes it.  It is not
    # global storage.  The storage itself is a Ruby hash.  If the second _name_
    # variable is provided it will return named hash.  This is useful so that
    # you can partition your storage needs into different hashes.
    #
    # storage_for(event.player)[:hunger] = true
    # storage_for(event.player).fetch(:hunger, false)
    #
    def storage_for(me, label=nil)
      players_storage[me.name][label]
    end
    
    def players_storage
      @players_storage ||= Hash.new { |hash, key| hash[key] = Hash.new { |h, k| h[k] = Hash.new } }
    end
    
    def storage_load(me, label=nil)
      File.open(File.join(getDataFolder, label|| '_default.data'), 'rb') do |io|
        players_storage[me.name][label] = Marshal.load io
      end
    end
    
    def storage_save(me, label=nil)
      File.open(File.join(getDataFolder, label || '_default.data'), 'wb') do |io|
        Marshal.dump(storage_for(me, label), io)
      end
    end
  end
end
