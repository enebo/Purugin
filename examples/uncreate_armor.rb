class UncreateArmor
  include Purugin::Plugin, Purugin::Items, Purugin::Recipes
  
  description 'UncreateArmor', 0.1

  def element_name(element)
    return :"#{element}_ingot" if element == :iron || element == :gold
    element
  end

  def on_enable
    [:iron, :diamond, :gold, :leather].each do |element|
      [[:helmet, 5], [:chestplate, 8], [:leggings, 7], 
       [:boots, 4]].each do |type, count|
        result_material = element_name(element)
        armor_name = :"#{element}_#{type}"
        result = item_stack(result_material, count)
        server.add_recipe shapeless_recipe(result, [1, armor_name])
      end
    end
  end
end
