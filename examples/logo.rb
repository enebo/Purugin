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
      log "turning #{degrees} degrees #{@location.yaw - degrees}"
      @location.yaw -= degrees
    end

    def pos
      puts "POS #{@location.to_a.join(", ")}"
    end

    def go(amount)
      turn 180 if amount < 0
      log "go #{amount} forward"
      direction = @location.direction # cache to prevent math
      amount.abs.times do
        loc = @location.add(direction).dup
        loc.x, loc.y, loc.z = loc.x.round, loc.y.round, loc.z.round
        pixel loc
      end
      turn 180 if amount < 0
    end

    def pixel(loc)
      puts "Changing [#{loc.to_a.join(", ")}] to #{@penstyle}"
      loc.block.change_type @penstyle
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
