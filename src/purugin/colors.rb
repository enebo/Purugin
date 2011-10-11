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
      "red" => ChatColor::RED, "light_purple" => ChatColor::LIGHT_PURPLE,
      "yellow" => ChatColor::YELLOW, "white" => ChatColor::WHITE,
      "0" => ChatColor::BLACK, "1" => ChatColor::DARK_BLUE,
      "2" => ChatColor::DARK_GREEN, "3" => ChatColor::DARK_AQUA,
      "4" => ChatColor::DARK_RED, "5" => ChatColor::DARK_PURPLE,
      "6" => ChatColor::GOLD, "7" => ChatColor::GRAY,
      "8" => ChatColor::DARK_GRAY, "9" => ChatColor::BLUE,
      "a" => ChatColor::GREEN, "b" => ChatColor::AQUA,
      "c" => ChatColor::RED, "d" => ChatColor::LIGHT_PURPLE,
      "e" => ChatColor::YELLOW, "f" => ChatColor::WHITE
    } 


    # You can use either {color_name} or &digit to specify colors
    # http://www.minecraftwiki.net/wiki/Classic_Server_Protocol#Color_Codes
    def colorize_string(string)
      string.to_s.gsub(/({[^}]+}|&[0-9a-f])/) do |name|
        if name =~ /^&/
          color_name = name[1..-1]
        else
          color_name = name[1..-2]
        end
        
        COLOR_MAP[color_name] ? COLOR_MAP[color_name] : DEFAULT
      end
    end
    alias :colorize :colorize_string
    
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
