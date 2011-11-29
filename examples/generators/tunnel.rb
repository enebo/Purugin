class TunnelGenerationPlugin
  include Purugin::Plugin
  description 'Tunnel Generator', 0.1

  def on_enable
    public_command('tunnel', 'tunnel depth, height, width, torches?, break_the_block?') do |me, *args|
      error? args.length >= 3, "Must provide at least depth height and width"
      depth = error? args[0].to_i, "Depth must be an integer value"
      height = error? args[1].to_i, "Height must be an integer value"
      width = error? args[2].to_i, "Width must be an integer value"
      torches = args.length > 3 && args[3].to_i == 1 ? true : false
      breakit = args.length > 4 && args[4].to_i == 1 ? true : false

      error? depth > 0 || height > 0 || width > 0, "Dims must be integers >0"
      me.msg "Creating tunnel #{depth}x#{height}x#{width}"

      start = me.location
      target = me.target_block
      begin
        # if me targets a block that is not next to my feet
        unless target.get_face(start.block).nil?
          facing = target.get_face(start.block).opposite_face
        else
          # than try to reach the targeted bock from my head position
          facing = target.get_face(start.block.block_at(:up)).opposite_face
        end
      rescue NoMethodError
        me.msg "I must stand next to the block with should be my tunnel!"
        # maybe return something smart here...
      end
      height_facing = target.rotate(facing,:up)
      width_facing = target.rotate(facing,:left)
      first_block = target.block_at(facing.opposite_face)
      
      1.upto(depth) do |depth_dist|
        deep_block = first_block.block_at(facing,depth_dist)
        height.times do |height_dist|
          block = deep_block.block_at(height_facing,height_dist)
          width.times do |width_dist|
            # The block will be mined (eg there will be a ItemStack with
            # its Material dropped) and changed to :air or to :torch
            
            if torches and (depth_dist%3)==0 and (width_dist==0 or width_dist==width-1) and height_dist==height-1
              # torched will be, however, not placed correctly but dropped on the ground.
              # this seems to be something with the south/west whatsoever rule...
              # If digging a tunnel to the west, everything is fine!
              block.block_at(width_facing,width_dist).break!(breakit,:torch)
            else
              block.block_at(width_facing,width_dist).break!(breakit)
            end

          end
        end
      end
      
      me.send_message "Done creating tunnel #{depth}x#{height}x#{width}"
    end
  end
end
