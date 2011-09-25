require 'rubygems'
require 'image_voodoo'

class PictureWallPlugin
  include Purugin::Plugin
  description 'PictureWall', 0.2
  required :Commands, :include => :Command
  
  def vga_color(r,g,b) 
    vga = 0
    vga += 4 if b > 85
    vga += 2 if g > 85
    vga += 1 if r > 85
    vga += 8 if r + b + g >= 255
    vga
  end

  java_import org.bukkit.DyeColor

  COLORS = [
    ['Ink Sac', DyeColor::BLACK],
    ['Rose Red', DyeColor::RED],
    ['Cactus Green', DyeColor::GREEN],
    ['Cocoa Beans', DyeColor::BROWN],
    ['Lapis Lazuli', DyeColor::BLUE],
    ['Purple Dye', DyeColor::PURPLE],
    ['Cyan Dye', DyeColor::CYAN],
    ['Light Gray Dye', DyeColor::SILVER],
    ['Gray Dye', DyeColor::GRAY],
    ['Pink Dye', DyeColor::PINK],
    ['Lime Dye', DyeColor::LIME],
    ['Dandelion Yellow', DyeColor::YELLOW],
    ['Light Blue Dye', DyeColor::LIGHT_BLUE],
    ['Magenta Dye', DyeColor::MAGENTA],
    ['Orange Dye', DyeColor::ORANGE],
    ['Bone Meal', DyeColor::WHITE]
  ]
  
  def on_enable
    command('/picture', 'make picture wall from url', nil) do |e, *args|
    end
  end
end



