require 'java'
require 'purugin/predicate'

class org::bukkit::block::Biome
  extend Purugin::Predicate

  enum_predicates

  # FIXME: consolidate this enum to cap format somewhere common
  def self.match_biome(str)
    name = str.to_s.upcase.gsub(/\s+/, '_')
    NAME_MAP[name]
  end
  
  NAME_MAP = {}
  values.each do |value|
    name = value.name.upcase.gsub(/\s+/, '_')
    NAME_MAP[name] = value
  end
end

