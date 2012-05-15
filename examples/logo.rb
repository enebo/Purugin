module Kernel
  def turtle(name=nil, entity=LogoPlugin::Turtle::DEFAULT_DRAWER, &block)
    LogoPlugin::Turtle.new name, entity, &block
  end
end

class LogoPlugin
  include Purugin::Plugin, Purugin::Tasks, Purugin::Colors
  description 'Logo', 0.2

  class Turtle
    DEFAULT_DRAWER = :chicken
    attr_reader :commands, :name

    def initialize(name, entity, &script)
      @name, @entity, @commands, @script = name, entity, [], script
      @subs = {}
    end

    def add_command(command, *args)
      @commands << [command, *args]
    end

    def method_missing(name, *args)
      if block_given?
        puts "Saving name"
        @subs[name] = Proc.new
      elsif @subs[name]
        puts "Calling name"
        instance_eval &@subs[name]
      else
        puts "Unknown command #{name}"
      end
    end

    def delay(time); add_command "delay", time; end
    def verbose(state); add_command "verbose", state; end
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

    def draw(interface, args)
      instance_exec(*args, &@script)
      interface.execute @name, @entity, @commands
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

    # Undraw any previous draw I have performed or someone elses drawing if op
    def undraw(me)
      block = me.target_block
      instance = @blocks[block]
      instance.undraw if instance && (me.op? || me == instance.player)
    end
  end

  class ExecutionAborted < Exception
  end

  class TurtleInterface
    include Purugin::Colors
    MAX_PIXEL_COUNT = 1000
    DEFAULT_BLOCK_TYPE = :wood
    attr_reader :player

    def initialize(sessions, player)
      @sessions, @player, @block_type = sessions, player, DEFAULT_BLOCK_TYPE
      @location = player.target_block.location.tap do |loc|
        loc.pitch = 0
        loc.yaw = 0
      end
      @verbose = false
      @markers = {}
      @original_blocks = {} # loc -> type
      @delay = 0.1
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

    def delay(amount)
      @delay = amount
    end

    def execute(name, drawer, commands)
      @drawer = @player.world.spawn_mob drawer, @location
      label = name ? name + ":" : ''
      commands.each do |cmd, *args|
        @player.msg "#{label}#{cmd} #{args.join(", ")}" if @verbose && cmd != "verbose"
        __send__ cmd, *args
      end
    rescue NoMethodError => e
      @player.msg red("#{name}: Unknown command #{e.name}")
    ensure
      @drawer.remove
    end

    def verbose(state)
      @verbose = state
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
      direction = @location.direction # cache to prevent math
      amount.abs.times do
        sleep @delay
        loc = @location.add(direction).clone
        loc.x, loc.y, loc.z = loc.x.round, loc.y.round, loc.z.round
        pixel loc
      end
      yaw 180 if amount < 0
    end

    def pixel(loc)
      @drawer.teleport(loc)
      puts "Changing [#{loc.to_a.join(", ")}] to #{@block_type}"
      block = loc.block
      original_type = block.type
      block.change_type @block_type unless @block_type == :none
      unless @original_blocks[block]
        @original_blocks[block] = original_type
        @sessions[block] = self
      end

      raise ExecutionAborted.new "Program has too many blocks (>#{MAX_PIXEL_COUNT})" if @original_blocks.size > MAX_PIXEL_COUNT
    end
  end

  def on_enable
    default = File.join(File.dirname(__FILE__), "logo")
    logo_directory = config.get!("logo.directory", default)
    sessions = TurtleSessions.new
    error = nil

    event(:entity_damage) do |e|
      e.cancelled = true
    end

    public_player_command('draw', 'draw logo file', '/draw file') do |me, *args|
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
          turtle.draw(TurtleInterface.new(sessions, me), args[1..-1])
        rescue Exception => e
          me.msg red("Problem executing logo app: #{$!}")
          break;
        end
      end
    end

    public_player_command('undraw', 'remove drawing', '/undraw') do |me, *|
      sessions.undraw me
    end
  end
end
