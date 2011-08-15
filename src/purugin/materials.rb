require 'java'

module Purugin
  # Convenience methods useful for dealing with anything which works with Materials.  Block is
  # one type which includes this.
  module Materials
    M = org.bukkit.Material
    MATERIAL_NAMES = {
      :air => M::AIR, :stone => M::STONE, :grass => M::GRASS, :dirt => M::DIRT,
      :cobbleston => M::COBBLESTONE, :wood => M::WOOD, :sapling => M::SAPLING,
      :bedrock => M::BEDROCK, :water => M::WATER, :stationary_water => M::STATIONARY_WATER,
      :lava => M::LAVA, :stationary_lava => M::STATIONARY_LAVA, :sand => M::SAND,
      :gravel => M::GRAVEL, :gold_ore => M::GOLD_ORE, :iron_ore => M::IRON_ORE,
      :coal_ore => M::COAL_ORE, :log => M::LOG, :leaves => M::LEAVES, :sponge => M::SPONGE,
      :glass => M::GLASS, :lapis_ore => M::LAPIS_ORE, :lapis_block => M::LAPIS_BLOCK,
      :dispenser => M::DISPENSER, :sandstone => M::SANDSTONE, :note_block => M::NOTE_BLOCK,
      :bed_block => M::BED_BLOCK, :powered_rail => M::POWERED_RAIL, :detector_rail => M::DETECTOR_RAIL,
      :web => M::WEB, :wool => M::WOOL, :yellow_flower => M::YELLOW_FLOWER, :red_rose => M::RED_ROSE,
      :brown_mushroom => M::BROWN_MUSHROOM, :red_mushroom => M::RED_MUSHROOM,
      :gold_block => M::GOLD_BLOCK, :iron_block => M::IRON_BLOCK, :double_step => M::DOUBLE_STEP,
      :step => M::STEP, :brick => M::BRICK, :tnt => M::TNT, :bookshelf => M::BOOKSHELF,
      :mossy_cobblestone => M::MOSSY_COBBLESTONE, :obsidian => M::OBSIDIAN,
      :torch => M::TORCH, :fire => M::FIRE, :mob_spawner => M::MOB_SPAWNER, :wood_stairs => M::WOOD_STAIRS,
      :chest => M::CHEST, :redstone_wire => M::REDSTONE_WIRE, :diamond_ore => M::DIAMOND_ORE,
      :diamond_block => M::DIAMOND_BLOCK, :workbench => M::WORKBENCH, :crops => M::CROPS,
      :soil => M::SOIL, :furnace => M::FURNACE, :burning_furnace => M::BURNING_FURNACE,
      :sign_post => M::SIGN_POST, :wooden_door => M::WOODEN_DOOR, :ladder => M::LADDER,
      :rails => M::RAILS, :cobblestone_stairs => M::COBBLESTONE_STAIRS,
      :wall_sign => M::WALL_SIGN, :lever => M::LEVER, :stone_plate => M::STONE_PLATE,
      :iron_door_block => M::IRON_DOOR_BLOCK, :wood_plate => M::WOOD_PLATE,
      :redstone_ore => M::REDSTONE_ORE, :glowing_redstone_ore => M::GLOWING_REDSTONE_ORE,
      :redstone_torch_off => M::REDSTONE_TORCH_OFF, :redstone_torch_on => M::REDSTONE_TORCH_ON,
      :stone_button => M::STONE_BUTTON, :snow => M::SNOW, :ice => M::ICE,
      :snow_block => M::SNOW_BLOCK, :cactus => M::CACTUS, :clay => M::CLAY,
      :sugar_cane_block => M::SUGAR_CANE_BLOCK, :jukebox => M::JUKEBOX, :fence => M::FENCE,
      :pumpkin => M::PUMPKIN, :netherrack => M::NETHERRACK, :soul_sand => M::SOUL_SAND,
      :glowstone => M::GLOWSTONE, :portal => M::PORTAL, :jack_o_lantern => M::JACK_O_LANTERN,
      :cake_block => M::CAKE_BLOCK, :diode_block_off => M::DIODE_BLOCK_OFF,
      :diode_block_on => M::DIODE_BLOCK_ON, :locked_chest => M::LOCKED_CHEST,
      # items
      :iron_spade => M::IRON_SPADE, :iron_pickaxe => M::IRON_PICKAXE,  :iron_axe => M::IRON_AXE,
      :flint_and_steel => M::FLINT_AND_STEEL, :apple => M::APPLE, :bow => M::BOW, :arrow => M::ARROW,
      :coal => M::COAL, :diamond => M::DIAMOND, :iron_ingot => M::IRON_INGOT, :gold_ingot => M::GOLD_INGOT,
      :iron_sword => M::IRON_SWORD, :wood_sword => M::WOOD_SWORD, :wood_spade => M::WOOD_SPADE,
      :wood_pickaxe => M::WOOD_PICKAXE, :wood_axe => M::WOOD_AXE, :stone_sword => M::STONE_SWORD,
      :stone_spade => M::STONE_SPADE, :stone_pickaxe => M::STONE_PICKAXE, :stone_axe => M::STONE_AXE,
      :diamond_sword => M::DIAMOND_SWORD, :diamond_spade => M::DIAMOND_SPADE,
      :diamond_pickaxe => M::DIAMOND_PICKAXE, :diamond_axe => M::DIAMOND_AXE, :stick => M::STICK,
      :bowl => M::BOWL, :mushroom_soup => M::MUSHROOM_SOUP, :gold_sword => M::GOLD_SWORD,
      :gold_spade => M::GOLD_SPADE, :gold_pickaxe => M::GOLD_PICKAXE, :gold_axe => M::GOLD_AXE,
      :string => M::STRING, :feather => M::FEATHER, :sulphur => M::SULPHUR, :wood_hoe => M::WOOD_HOE,
      :stone_hoe => M::STONE_HOE, :iron_hoe => M::IRON_HOE, :diamond_hoe => M::DIAMOND_HOE,
      :gold_hoe => M::GOLD_HOE, :seeds => M::SEEDS, :wheat => M::WHEAT, :bread => M::BREAD,
      :leather_helmet => M::LEATHER_HELMET, :leather_chestplate => M::LEATHER_CHESTPLATE,
      :leather_leggings => M::LEATHER_LEGGINGS, :leather_boots => M::LEATHER_BOOTS,
      :chainmail_helmet => M::CHAINMAIL_HELMET, :chainmail_chestplate => M::CHAINMAIL_CHESTPLATE,
      :chainmail_leggings => M::CHAINMAIL_LEGGINGS, :chainmail_boots => M::CHAINMAIL_BOOTS,
      :iron_helmet => M::IRON_HELMET, :iron_chestplate => M::IRON_CHESTPLATE,
      :iron_leggings => M::IRON_LEGGINGS, :iron_boots => M::IRON_BOOTS,
      :diamond_helmet => M::DIAMOND_HELMET, :diamond_chestplate => M::DIAMOND_CHESTPLATE,
      :diamond_leggings => M::DIAMOND_LEGGINGS, :diamond_boots => M::DIAMOND_BOOTS,
      :gold_helmet => M::GOLD_HELMET, :gold_chestplate => M::GOLD_CHESTPLATE,
      :gold_leggings => M::GOLD_LEGGINGS, :gold_boots => M::GOLD_BOOTS,
      :flint => M::FLINT, :pork => M::PORK, :grilled_pork => M::GRILLED_PORK,
      :painting => M::PAINTING, :golden_apple => M::GOLDEN_APPLE, :sign => M::SIGN,
      :wood_door => M::WOOD_DOOR, :bucket => M::BUCKET, :water_bucket => M::WATER_BUCKET,
      :lava_bucket => M::LAVA_BUCKET, :minecard => M::MINECART, :saddle => M::SADDLE,
      :iron_door => M::IRON_DOOR, :redstone => M::REDSTONE, :snow_ball => M::SNOW_BALL, :boat => M::BOAT,
      :leather => M::LEATHER, :milk_bucket => M::MILK_BUCKET, :clay_brick => M::CLAY_BRICK,
      :clay_ball => M::CLAY_BALL, :sugar_cane => M::SUGAR_CANE, :paper => M::PAPER, :book => M::BOOK,
      :slime_ball => M::SLIME_BALL, :storage_minecart => M::STORAGE_MINECART,
      :powered_minecart => M::POWERED_MINECART, :egg => M::EGG, :compass => M::COMPASS,
      :fishing_rod => M::FISHING_ROD, :watch => M::WATCH, :glowstone_dust => M::GLOWSTONE_DUST,
      :raw_fish => M::RAW_FISH, :cooked_fish => M::COOKED_FISH, :ink_sack => M::INK_SACK,
      :bone => M::BONE, :sugar => M::SUGAR, :cake => M::CAKE, :bed => M::BED, :diode => M::DIODE,
      :cookie => M::COOKIE, :gold_record => M::GOLD_RECORD, :green_record => M::GREEN_RECORD
    }
    
    # Is this block any of the supplied values (see MATERIAL_NAMES constant for a full list)?
    # === Parameters
    # * _values_ one or more symbols from MATERIAL_NAMES that you want to test against
    # === Example
    # grass_block.is? :grass        #=> true
    # grass_block.is? :wood, :stone #=> false
    #
    def is?(*values)
      !!values.find() {|value| MATERIAL_NAMES[value] == type }
    end  
  end
end