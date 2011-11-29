class TunnelGenerationPlugin
  include Purugin::Plugin
  description 'Tunnel Generator', 0.1
  #required :Commands, :include => :Command
  
  def on_enable
    public_command('tunnel', 'tunnel depth, height, width, torches?') do |me, *args|
      depth = error? args[0].to_i, "Depth must be an integer value"
      height = error? args[1].to_i, "Height must be an integer value"
      width = error? args[2].to_i, "Width must be an integer value"
      torches = args.length > 3 ? args[3] : false

      error? depth > 0 || height > 0 || width > 0, "Dims must be integers >0"
      me.msg "Creating tunnel #{depth}x#{height}x#{width}"

      start = me.location
      begin                                                
        # if me targets a block that is not next to my feet
        unless me.target_block.get_face(me.location.get_block).nil?
          facing = me.target_block.get_face(me.location.get_block).get_opposite_face
        else
          # than try to reach the targeted bock from my head position
          facing = me.target_block.get_face(me.location.get_block.block_at(:up)).get_opposite_face
        end
      rescue NoMethodError
        me.msg "I must stand next to the block with should be my tunnel!"
        # maybe return something smart here...
      end
      height_facing = me.target_block.rotate(facing,:up)
      width_facing = me.target_block.rotate(facing,:left)
      first_block = me.target_block.block_at(facing.get_opposite_face)
      
      1.upto(depth) do |depth_dist|
        deep_block = first_block.block_at(facing,depth_dist)
        height.times do |height_dist|
          block = deep_block.block_at(height_facing,height_dist)
          width.times do |width_dist|
            # for now the block will only be replaced by air. No mining.
            block.block_at(width_facing,width_dist).break!
          end
        end
      end
      
      me.send_message "Done creating tunnel #{depth}x#{height}x#{width}"
    end
  end
end