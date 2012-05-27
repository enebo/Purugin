require 'purugin/action'

class org::bukkit::event::player::PlayerInteractEvent
  include Purugin::Action
  
  def block?
    has_block
  end
  
  def item?
    has_item
  end
end

