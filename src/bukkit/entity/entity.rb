require 'java'

module org::bukkit::entity::Entity
  def creature?
    false
  end

  def living?
    false
  end
  
  def monster?
    true
  end  
  
  def player?
    false
  end 
end

