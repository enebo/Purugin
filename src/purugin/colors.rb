module Purugin
  module Colors
    java_import org.bukkit.ChatColor
    
    DEFAULT=ChatColor::WHITE
    
    # Change to the specified color and then to the done color (which defaults to white)
    def color(color, message, done_color=DEFAULT)
      "#{color}#{message}#{done_color}"
    end
    
    COLOR_MAP = {"black" => ChatColor::BLACK, "dark_blue" => ChatColor::DARK_BLUE,
      "dark_green" => ChatColor::DARK_GREEN, "dark_aqua" => ChatColor::DARK_AQUA, 
      "dark_red" => ChatColor::DARK_RED, "dark_purple" => ChatColor::DARK_PURPLE,
      "gold" => ChatColor::GOLD, "gray" => ChatColor::GRAY,
      "dark_gray" => ChatColor::DARK_GRAY, "blue" => ChatColor::BLUE,
      "green" => ChatColor::GREEN, "aqua" => ChatColor::AQUA,
      "red" => ChatColor::RED, "light_purple" => ChatColor::LIGHT_PURPLE
    } 

    def colorize_string(string)
      string.to_s.gsub(/{[^}]+}/) do |name|
        color_name = name[1..-2]
        COLOR_MAP[color_name] ? COLOR_MAP[color_name] : DEFAULT
      end
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
