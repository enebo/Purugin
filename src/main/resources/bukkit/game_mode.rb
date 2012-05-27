require 'java'

class org::bukkit::GameMode
  MODES = {} # :creative => 1, etc...
  values.each do |mode|
    MODES[mode.to_s.downcase] = mode
  end
  
  # Given a string or symbol :creative (or any acceptable mode) give me
  # The actual GameMode value
  # === parameters
  # *_str_* value to get mode for (e.g. 'creative' or :survival)
  # === examples
  # GameMode.string_as_mode(:creative) #=> org.bukkit.GameMode value
  def self.string_as_mode(str)
    MODES[str.to_s]
  end 
end
