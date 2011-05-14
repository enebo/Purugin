module Purugin
  module Colors
    java_import org.bukkit.ChatColor
    
    DEFAULT=ChatColor::WHITE
    
    # Change to the specified color and then to the done color (which defaults to white)
    def color(color, message, done_color=DEFAULT)
      "#{color}#{message}#{done_color}"
    end
    
    def black(message); color(ChatColor::BLACK, message); end
    def dark_blue(message); color(ChatColor::DARK_BLUE, message); end
    def dark_green(message); color(ChatColor::DARK_GREEN, message); end
    def dark_aqua(message); color(ChatColor::DARK_AQUA, message); end
    def dark_red(message); color(ChatColor::DARK_RED, message); end
    def dark_purple(message); color(ChatColor::DARK_PURPLE, message); end
    def gold(message); color(ChatColor::GOLD, message); end
    def gray(message); color(ChatColor::GRAY, message); end
    def dark_gray(message); color(ChatColor::DARK_GRAY, message); end
    def blue(message); color(ChatColor::BLUE, message); end
    def green(message); color(ChatColor::GREEN, message); end
    def aqua(message); color(ChatColor::AQUA, message); end
    def red(message); color(ChatColor::RED, message); end
    def light_purple(message); color(ChatColor::LIGHT_PURPLE, message); end
    def yellow(message); color(ChatColor::YELLOW, message); end
    def white(message); color(ChatColor::WHITE, message); end    
  end
end
