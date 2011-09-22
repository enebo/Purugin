class MazeGenerationPlugin
  include Purugin::Plugin
  description 'Maze Generator', 0.1
  
  # Logic distilled from makemaze.c from the ascii game:  Hunt
  class Maze
    NORTH, SOUTH, EAST, WEST = 1, 2, 4, 8
    DOOR, SPACE, WALL1, WALL2, WALL3 = '#', ' ', '-', '|', '+'
    
    def initialize(width, height)
      @height, @width = height, width
      @maze = Array.new(height) { Array.new(width, DOOR) }
      make_maze
    end
    
    def make_maze
      x = rand(@width / 2) * 2 + 1
      y = rand(@height / 2) * 2 + 1
      dig_maze(x, y)
    end
    
    def dig_maze(x, y)
      @maze[y][x] = SPACE
      order = [NORTH, 0, 0, 0]
      1.upto(3) do |i|
        j = rand(i)
        order[i] = order[j]
        order[j] = 1 << i
      end
      
      order.each do |dir|
        case(dir)
        when NORTH then
          tx, ty = x, y - 2
        when SOUTH then
          tx, ty = x, y + 2
        when EAST then
          tx, ty = x + 2, y
        when WEST then
          tx, ty = x - 2, y
        end
        
        next if tx < 0 || ty < 0 || tx >= @width || ty >= @height
        next if @maze[ty][tx] == SPACE
        
        @maze[(y + ty) / 2][(x + tx) / 2] = SPACE
        
        dig_maze tx, ty
      end
    end
    
    def to_s
      @maze.each { |row| puts row.inject("") { |s, e| s << e } }
    end
    
    def render_to(block, type)
      row_block = block
      @maze.each do |row| 
        column_block = row_block
        row.each do |value|
          column_block.change_type type if value != SPACE
          column_block = column_block.block_at(:west)
        end
        row_block = row_block.block_at(:north)
      end
    end
  end  
  
  def on_enable
    public_command('maze', 'make m by n maze of type', '/maze {w} {h} {type}?') do |me, *args|
      width = error? args[0].to_i, "width must be an odd integer"
      height = error? args[1].to_i, "height must be an odd integer"      
      error? width > 3 && width.odd?, "Width must be >3 and odd"
      error? height > 3 && height.odd?, "Height must be >3 and odd"      
      block = error? me.target_block, "No target block selected"
      type = args.length > 2 ? args[2].to_sym : :glass

      me.msg "Creating maze of #{type} and dims #{width}x#{height}"
      Maze.new(width, height).render_to(block.block_at(:up), type)
      me.msg "Done creating maze of #{type}"
    end
  end
end