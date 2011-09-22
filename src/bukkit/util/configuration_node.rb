require 'java'

class org::bukkit::util::config::ConfigurationNode
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