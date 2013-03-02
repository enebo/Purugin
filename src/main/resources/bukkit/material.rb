class org::bukkit::Material
  def is?(type)
    self == org::bukkit::Material::match_material(type.to_s)
  end
  
  def to_material
    self
  end
end
