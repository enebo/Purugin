module Kernel
  def turtle(&block)
    LogoPlugin::Turtle.start &block
  end
end

# TODO: better execution protection
# TODO: make abort work in async_blocks
# TODO: Add 3d support
# TODO: Add better jump

class LogoPlugin
  include Purugin::Plugin, Purugin::Tasks
  description 'Logo', 0.2

  class Turtle
    attr_reader :commands

    def initialize()
      @commands = []
    end

    def self.start(&script)
      new.tap { |t|  t.instance_eval(&script) }
    end

    def add_command(command, *args)
      @commands << [command, *args]
    end

    def pencolor(color)
      add_command "penstyle", color
    end
    
    def log(message)
      add_command "log", message
    end

    def pos
      add_command "pos"
    end

    def goto(x, y)
      add_command "goto", x, y
    end

    def forward(distance)
      add_command "go", distance
    end

    def backward(distance)
      add_command "go", -distance
    end

    def turnleft(degrees)
      add_command "turn", -degrees.abs
    end

    def turnright(degrees)
      add_command "turn", degrees.abs
    end

    def draw(interface)
      interface.execute @commands
    end
  end

  class TurtleInterface
    DEFAULT_PENSTYLE = :wood

    def initialize(player)
      @player, @penstyle = player, DEFAULT_PENSTYLE
      @location = player.target_block.location.tap do |loc|
        loc.pitch = 0
        loc.yaw = 0
      end
    end

    def server
      @player.server
    end

    def execute(commands)
      commands.each do |cmd, *args|
        @player.msg "exec'ing #{cmd}(#{args.join(", ")})"
        puts "exec'ing #{cmd}(#{args.join(", ")})"
        __send__ cmd, *args
      end
    rescue NoMethodError
      puts $!.caller
    end

    def penstyle(type)
      @penstyle = type.to_sym
    end

    def log(message)
      @player.msg message
    end

    def turn(degrees)
      log "turning #{degrees} degrees"
      @location.yaw -= degrees
    end

    def pos
      puts "POS #{@location.to_a.join(", ")}"
    end

    def go(amount)
      log "go #{amount} forward"
      loc0 = @location
      loc1 = loc0.clone
      loc1.add(loc1.direction.multiply(amount))
      line(loc0, loc1)
      @location = loc1
    end

    # Drawing in a specific order is painful and I am sure this can be
    # boiled down better than it has so far...also not so great at some angles.
    def line(loc0, loc1)
      puts "LOC0 #{loc0.to_a.join(", ")} -> #{loc1.to_a.join(", ")}"
      dx = loc1.x - loc0.x
      dz = loc1.z - loc0.z

      if dx == 0 # vertical line
        puts "VERT"
        s, e = loc0, loc1
        if s.z <= e.z
          puts "S<E Z #{s.z < e.z} #{s.z} #{e.z}"
          z = s.z
          while z < e.z
            puts "PIX #{z}"
            s.z = z
            pixel(s)
            z += 1
          end
        else
          z = s.z
          puts "S>E Z"
          while z > e.z
            puts "PIX #{z}"
            s.z = z
            pixel(s)
            z -= 1
          end
        end
      elsif dx.abs > 1 # More rise than run
        puts "RISE>RUN"
        s, e = loc0, loc1
        m = dz / dx
        z = s.z
        if s.x <= e.x
          puts "S<E x"
          while s.x < e.x
            puts "PIX #{z}"
            s.z = z.round
            pixel(s)
            z += (m == 0) ? 0 : (1/m)
            s.x += 1
            puts "S<E Z #{s.x < e.x} #{s.x} #{e.x}"
          end
        else
          puts "S>E Z"
          while s.x > e.x
            puts "PIX #{z}"
            s.z = z.round
            pixel(s)
            z -= (m == 0) ? 0 : (1/m)
            s.x -= 1
            puts "S<E Z #{s.x > e.x} #{s.x} #{e.x}"
          end
        end        
      else # More run than rise
        puts "RUN>RISE"
        s, e = loc0, loc1
        m = dz / dx
        z = s.z
        if s.x <= e.x
          while s.x < e.x
            s.z = z.round
            pixel(s)
            z += m
            s.x += 1
          end
        else
          while s.x > e.x
            s.z = z.round
            pixel(s)
            z -= m
            s.x -= 1
          end
        end        
      end
    end

    # Bresenham's line algo (consider making 3d bres algo)
    def line2(loc0, loc1)
      puts "LOC0 #{loc0.to_a.join(", ")} -> #{loc1.to_a.join(", ")}"
      dx, dz = (loc1.x - loc0.x).abs, (loc1.z - loc0.z).abs
      sx = loc0.x < loc1.x ? 1 : -1
      sz = loc0.z < loc1.z ? 1 : -1
      err = dx - dz
 
      loop do
        puts "Loop"
        sleep 0.5
        pixel(loc0)
        break if loc0.x.abs >= loc1.x.abs
        e2 = err*2
        if e2 > -dz
          err -= dz
          loc0.add(sx, 0, 0)
        end
        if e2 < dx
          err += dx
          loc0.add(0, 0, sz)
        end
      end
    end

    def pixel(loc)
      puts "Changing [#{loc.to_a.join(", ")}] to #{@penstyle}"
      @player.world.block_at(loc).change_type @penstyle
    end
  end

  def on_enable
    default = File.join(File.dirname(__FILE__), "logo")
    logo_directory = config.get!("logo.directory", default)

    player_command('draw', 'draw logo file', '/draw file') do |me, *args|
      abort! "No program supplied" if args.length == 0
      program = args[0].to_s
      filename = File.join(logo_directory, program + '.rb')
      abort! "No such file #{program}" unless File.exist?(filename)
      async_task do
        begin
          turtle = eval File.readlines(filename).join("\n")
        rescue Exception => e
          abort! "Problem loading logo app: #{$!}"
        end

        abort! "Not a turtle program #{program}" unless turtle.kind_of? Turtle
        
        begin
          turtle.draw(TurtleInterface.new(me))
        rescue Exception => e
          abort! "Problem executing logo app: #{$!}"
        end
      end
    end
  end
end
