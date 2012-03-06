require 'java'

module org::bukkit::configuration::ConfigurationSection
  # Get 
  def get(path)
    getProperty(path)
  end
  
  def get!(path, default_value)
    value = get path
    value = set! path, default_value unless value
    value
  end
  
  def get_boolean!(path, default_value)
    set! path, get_boolean(path, default_value)
  end
  
  def get_float!(path, default_value)
    set! path, get_double(path, default_value)
  end
  
  def get_fixnum!(path, default_value)
    set! path, get_int(path, default_value)
  end
  
  def get_string!(path, default_value)
    set! path, get_string(path, default_value)
  end
  
  # Once setProperty/removeProperty is called also save this Configuration
  def set!(path, value)
    set path, value
# FIXME: configuration no longer has ability to save without explicit File reference?    
#    save if respond_to? :save # Only Configuration can save
    value
  end
  
  def remove!(path)
    remove path
# FIXME: configuration no longer has ability to save without explicit File reference?  
#     save if respond_to? :save # Only Configuration can save
    path
  end
end
