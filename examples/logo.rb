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

    def mark(name)
      add_command "mark", name
    end

    def pos
      add_command "pos"
    end

    def goto(name)
      add_command "goto", name
    end

    def forward(distance)
      add_command "go", distance
    end

    def backward(distance)
      add_command "go", -distance
    end

    def turnleft(degrees)
      add_command "yaw", degrees
    end

    def turnright(degrees)
      add_command "yaw", -degrees
    end

    def turnup(degrees)
      add_command "pitch", -degrees
    end

    def turndown(degrees)
      add_command "pitch", degrees
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
      @markers = {}
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

    def mark(name)
      @markers[name] = @location.clone
      puts "marked #{name} -> #{@location}"
    end

    def goto(name)
      @location = @markers[name].clone
      puts "goto #{name} -> #{@location}"
    end

    def penstyle(type)
      @penstyle = type.to_sym
    end

    def log(message)
      @player.msg message
    end

    def yaw(degrees)
      new_yaw = @location.yaw + degrees
      if new_yaw >= 360.0
        new_yaw = new_yaw - 360.0
      elsif new_yaw <= 0
        new_yaw = 360.0 + new_yaw
      end
      puts "new yaw: #{new_yaw}"
      @location.yaw = new_yaw
    end

    def pitch(degrees)
      new_pitch = @location.pitch + degrees
      if new_pitch >= 360.0
        new_pitch = new_pitch - 360.0
      elsif new_pitch <= 0
        new_pitch = 360.0 + new_pitch
      end
      puts "new pitch: #{new_pitch}"
      @location.pitch = new_pitch
    end

    def pos
      puts "POS #{@location.to_a.join(", ")}"
    end

    def go(amount)
      yaw 180 if amount < 0
      log "go #{amount} forward"
      direction = @location.direction # cache to prevent math
      amount.abs.times do
        loc = @location.add(direction).clone
        loc.x, loc.y, loc.z = loc.x.round, loc.y.round, loc.z.round
        pixel loc
      end
      yaw 180 if amount < 0
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
          puts e
          abort! "Problem executing logo app: #{$!}"
        end
      end
    end
  end
end
