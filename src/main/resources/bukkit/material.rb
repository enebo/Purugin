class org::bukkit::Material
  def is?(type, legacy=false)
    self == org::bukkit::Material::match_material(type.to_s, legacy)
  end

  def is_legacy?(type)
    is?(type, true)
  end

  def to_material
    self
  end
end
