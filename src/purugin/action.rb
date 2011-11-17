module Purugin
  module Action
    A = org.bukkit.event.block.Action
    def left_click_block?
      getAction == A::LEFT_CLICK_BLOCK
    end
    
    def left_click_air?
      getAction == A::LEFT_CLICK_AIR
    end
    
    def right_click_block?
      getAction == A::RIGHT_CLICK_BLOCK
    end
    
    def right_click_air?
      getAction == A::RIGHT_CLICK_AIR
    end
    
    def physical?
      getAction == A::PHYSICAL
    end
    
    def clicked_air?
      left_click_air? || right_click_air?
    end
    
    def clicked_block?
      left_click_block? || right_click_block?
    end
  end
end

