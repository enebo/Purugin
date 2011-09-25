require 'java'

class org::bukkit::util::config::ConfigurationNode
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
    setProperty path, value
    save if respond_to? :save # Only Configuration can save
    value
  end
  
  def remove!(path)
    removeProperty path
    save if respond_to? :save # Only Configuration can save
    path
  end
end