class org::bukkit::Material
  def is?(type)
    self == org::bukkit::Material::match_material(type.to_s)
  end
end
