require 'java'

class org::bukkit::util::config::ConfigurationNode
  # Once setProperty/removeProperty is called also save this Configuration
  def set!(path, value)
    setProperty path, value
    save
  end
  
  def remove!(path)
    removeProperty path
    save
  end
end