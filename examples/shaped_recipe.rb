class ShapedRecipeExample
  include Purugin::Plugin, Purugin::Items, Purugin::Recipes
  
  description 'ShapedRecipe', 0.1

  PATTERN = <<-EOS
xyx
yxy
xyx
  EOS

  def on_enable
    result = item_stack(:fence, 1)
    server.add_recipe shaped_recipe(result, pattern, x: :wood, y: :gravel)
  end
end
