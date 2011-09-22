class TunnelGenerationPlugin
  include Purugin::Plugin
  description 'Tunnel Generator', 0.1
  required :Commands, :include => :Command
  
  def on_enable
    public_command('tunnel', 'tunnel depth, height, width, torches?') do |me, *args|
      depth = error? args[0].to_i, "Depth must be an integer value"
      height = error? args[1].to_i, "Height must be an integer value"
      width = error? args[2].to_i, "Width must be an integer value"
      torches = args.length > 3 ? args[3] : false

      error? depth <= 0 || height <= 0 || width <=0, "Dims must be integers >0"

      me.msg "Creating tunnel #{depth}x#{height}x#{width}"
      
      start = me.location
      facing = me.target_block(start).opposite_face
      height_facing = facing.rotate :up
      width_facing = facing.rotate :left
      puts "DIRECTION is #{direction}"
      depth.times do
        block = me.block_at(facing)
        block.change_type :air
      end
      dim.times do 
        block = block.block_at(:up)
        block.change_type type
      end
      me.send_message "Done creating cube of #{type} and size #{dim}"      
    end
  end
end
