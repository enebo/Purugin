require 'java'
require 'purugin/predicate'

module org::bukkit::entity::Entity
  extend Purugin::Predicate

  predicate :item, org::bukkit::entity::Item  
  predicate :flying, org::bukkit::entity::Flying
  predicate :living, org::bukkit::entity::LivingEntity
  predicate :human, org::bukkit::entity::HumanEntity
  predicate :creature, org::bukkit::entity::Creature
  predicate :animal, org::bukkit::entity::Animals 
  predicate :chicken, org::bukkit::entity::Chicken
  predicate :cow, org::bukkit::entity::Cow
  predicate :fish, org::bukkit::entity::Fish
  predicate :pig, org::bukkit::entity::Pig
  predicate :sheep, org::bukkit::entity::Sheep
  predicate :wolf, org::bukkit::entity::Wolf
  
  predicate :monster, org::bukkit::entity::Monster 
  predicate :cave_spider, org::bukkit::entity::CaveSpider
  predicate :creeper, org::bukkit::entity::Creeper
  predicate :enderman, org::bukkit::entity::Enderman 
  predicate :giant, org::bukkit::entity::Giant
  predicate :pig_zombie, org::bukkit::entity::PigZombie
  predicate :silverfish, org::bukkit::entity::Silverfish  
  predicate :skelton, org::bukkit::entity::Skeleton
  predicate :slime, org::bukkit::entity::Slime
  predicate :spider, org::bukkit::entity::Spider
  predicate :zombie, org::bukkit::entity::Zombie
  
  predicate :water_mob, org::bukkit::entity::WaterMob
  predicate :squid, org::bukkit::entity::Squid
  
  predicate :player, org::bukkit::entity::Player

  predicate :powered_minecart, org::bukkit::entity::PoweredMinecart
  predicate :lightning_strike, org::bukkit::entity::LightningStrike 
  predicate :boat, org::bukkit::entity::Boat
  predicate :storage_minecart, org::bukkit::entity::StorageMinecart
  predicate :falling_sand, org::bukkit::entity::FallingSand
  predicate :explosive, org::bukkit::entity::Explosive
  predicate :painting, org::bukkit::entity::Painting
  predicate :egg, org::bukkit::entity::Egg
  predicate :fireball, org::bukkit::entity::Fireball
  predicate :vehicle, org::bukkit::entity::Vehicle
  predicate :experience_orb, org::bukkit::entity::ExperienceOrb
  predicate :snowball, org::bukkit::entity::Snowball
  predicate :projectile, org::bukkit::entity::Projectile
  predicate :arrow, org::bukkit::entity::Arrow
  predicate :tnt_primed, org::bukkit::entity::TNTPrimed
  predicate :minecart, org::bukkit::entity::Minecart
  predicate :weather, org::bukkit::entity::Weather
  
  # Is this entity a particular type of entity
  # === Examples
  # entity.is? arrow
  # === Notes
  # For builtin game types it is simpler to directly use the predicate defined for it:
  # entity.arrow?
  # However for extended entity types added by mods this method will be needed.
  # TODO: Add support for determining type of extends mod entity types.
  
  def get_entity
    entity_name = self.getCreatureType().getName()
    if respond_to? entity_name
      entity_name
    end
    false
  end
  
  def is?(type)
    predicate_name = type.to_s + "?"
    if respond_to? predicate_name
      __send__ predicate_name
    end
    false
  end
  
  def name
    creature_name = self.get_entity.gsub(/(.)([A-Z])/, '\1 \2')
    if respond_to? creature_name
      creature_name
    end
    false
  end
end

