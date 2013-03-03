module Purugin
  ##
  # Use this module to include helper methods for dealing with the use and creation of recipes
  module Recipes
    ##
    # Create a shapeless recipe with the itemstack 'result' which requires the supplied list of
    # ingrediants.
    #
    # === Examples: ===
    #   server.add_recipe = shapeless_recipe(item_stack(:mossy_cobblestone, 10), 
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
    
    ##
    # Create a shaped recipe where ingredients are required to be put in a particular pattern
    # to craft an item.
    #
    # === Examples: ===
    # 
    # server.add_recipe shaped_recipe(item_stack(:sand, 10), "xy\nyx\n", x: :wood, y: :gravel)
    #
    def shaped_recipe(result, pattern, letter_mappings)
      raise ArgumentError.new("Pattern must be n by n newline-delimited string of chars") unless pattern
      raise ArgumentError.new("Must provide char mappings to the pattern") if letter_mappings.size < 1
      rows = pattern.split(/\n/)
      
      raise ArgumentError.new("Pattern must be >0 and <3 in n by b size") if rows.find {|row| row.size < 1 || rows.size > 3}
      
      org.bukkit.inventory.ShapedRecipe.new(result).tap do |recipe|
        recipe.shape(*rows)
        letter_mappings.each do |char, ingredient|
          if ingredient.kind_of? Array
            ingredient, amount = *ingredient
            recipe.set_ingredient(char.to_s.ord, ingredient.to_material, amount)
          else
            recipe.set_ingredient(char.to_s.ord, ingredient.to_material)
          end
        end
      end
    end
  end
end
