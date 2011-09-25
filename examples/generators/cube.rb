class CubeGenerationPlugin
  include Purugin::Plugin
  description 'Cube Generator', 0.2
  
  def on_enable
    public_command('cube', 'make n^3 cube of type', '/cube {dim}') do |me, *args|
      dim = error? args[0].to_i, "Must specify an integer size"
      error? dim > 0, "Size must be an integer >0"
      type = args.length > 1 ? args[1].to_sym : :glass
      z_block = error? me.target_block.block_at(:up), "No block targeted"

      me.msg "Creating cube of #{type} and size #{dim}"      
      dim.times do
	y_block = z_block
	dim.times do
	  x_block = y_block
	  dim.times do
	    x_block.change_type type
	    x_block = x_block.block_at(:north)
	  end
	  y_block = y_block.block_at(:east)
	end
	z_block = z_block.block_at(:up)
      end
      me.msg "Done creating cube of #{type} and size #{dim}"      
    end
  end
end
