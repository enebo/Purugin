module Purugin
  ##
  # Use this module to include helper methods for dealing with the use and creation of recipes
  module Recipes
    ##
    # Create a shapeless recipe with the itemstack 'result' which requires the supplied list of
    # ingrediants.
    #
    # === Examples: ===
    #   server.add_recipe = shapeless_recipe(item_list(:mossy_cobblestone, 10), 
    #                                        [[10, :gold_nugget], [10, :cobblestone]])
    #
    def shapeless_recipe(result, *ingredients)
      raise ArgumentError.new("Must supplied list of ingredient lists") if ingredients.size < 1
      
      org.bukkit.inventory.ShapelessRecipe.new(result).tap do |recipe|
        ingredients.each do |count, material|
          recipe.add_ingredient count.to_i, material.to_material
        end
      end
    end
  end
end
