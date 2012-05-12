module Kernel
  def turtle(&block)
    LogoPlugin::Turtle.start &block
  end
end

# TODO: better execution protection
# TODO: make abort work in async_blocks

class LogoPlugin
  include Purugin::Plugin, Purugin::Tasks, Purugin::Colors
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

    def block(type); add_command "block", type; end
    def log(message); add_command "log", message; end
    def mark(name); add_command "mark", name; end
    def pos; add_command "pos"; end
    def goto(name); add_command "goto", name; end
    def forward(distance); add_command "go", distance; end
    def backward(distance); add_command "go", -distance; end
    def turnleft(degrees); add_command "yaw", degrees; end
    def turnright(degrees); add_command "yaw", -degrees; end
    def turnup(degrees); add_command "pitch", -degrees; end
    def turndown(degrees); add_command "pitch", degrees; end

    def draw(interface)
      interface.execute @commands
    end
  end

  class TurtleSessions
    def initialize
      @blocks = {} # block -> interface_instance
    end

    def []=(block, instance)
      @blocks[block] = instance
    end

    def delete(block)
      @blocks.delete(block)
    end

    def undraw(block)
      instance = @blocks[block]
      instance.undraw if instance
    end
  end

  class TurtleInterface
    DEFAULT_BLOCK_TYPE = :wood

    def initialize(sessions, player)
      @sessions, @player, @block_type = sessions, player, DEFAULT_BLOCK_TYPE
      @location = player.target_block.location.tap do |loc|
        loc.pitch = 0
        loc.yaw = 0
      end
      @markers = {}
      @original_blocks = {} # loc -> type
    end

    # Undraw/revert all blocks changed by this turtleinterface
    def undraw
      @original_blocks.each_pair do |block, block_type|
        @sessions.delete(block)
        block.change_type block_type
      end
      @original_blocks = {}
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

    def block(type)
      @block_type = type.to_sym
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
      puts "Changing [#{loc.to_a.join(", ")}] to #{@block_type}"
      block = loc.block
      original_type = block.type
      block.change_type @block_type unless @block_type == :none
      unless @original_blocks[block]
        @original_blocks[block] = original_type
        @sessions[block] = self
      end
    end
  end

  def on_enable
    default = File.join(File.dirname(__FILE__), "logo")
    logo_directory = config.get!("logo.directory", default)
    sessions = TurtleSessions.new
    error = nil

    player_command('draw', 'draw logo file', '/draw file') do |me, *args|
      abort! "No program supplied" if args.length == 0
      program = args[0].to_s
      filename = File.join(logo_directory, program + '.rb')
      abort! "No such file #{program}" unless File.exist?(filename)
      async_task do
        begin
          turtle = eval File.readlines(filename).join("\n")
        rescue Exception => e
          me.msg red("Problem loading logo app: #{$!}")
          break;
        end

        unless turtle.kind_of? Turtle  # pretty ugly for asyc
          me.msg red("Not a turtle program #{program}")
          break
        end
        
        begin
          turtle.draw(TurtleInterface.new(sessions, me))
        rescue Exception => e
          me.msg red("Problem executing logo app: #{$!}")
          break;
        end
      end
    end

    player_command('undraw', 'remove drawing', '/undraw') do |me, *|
      sessions.undraw me.target_block
    end
  end
end
