require 'java'
require 'purugin/predicate'

module org::bukkit::entity::Entity
  extend Purugin::Predicate

  predicate org::bukkit::entity::Item  
  predicate org::bukkit::entity::Flying
  predicate org::bukkit::entity::LivingEntity, :living
  predicate org::bukkit::entity::HumanEntity, :human
  predicate org::bukkit::entity::Creature
  predicate org::bukkit::entity::Animals, :animal
  predicate org::bukkit::entity::Chicken
  predicate org::bukkit::entity::Cow
  predicate org::bukkit::entity::Fish
  predicate org::bukkit::entity::Pig
  predicate org::bukkit::entity::Sheep
  predicate org::bukkit::entity::Wolf
  
  predicate org::bukkit::entity::Monster 
  predicate org::bukkit::entity::CaveSpider
  predicate org::bukkit::entity::Creeper
  predicate org::bukkit::entity::Enderman 
  predicate org::bukkit::entity::Giant
  predicate org::bukkit::entity::PigZombie
  predicate org::bukkit::entity::Silverfish  
  predicate org::bukkit::entity::Skeleton
  predicate org::bukkit::entity::Slime
  predicate org::bukkit::entity::Spider
  predicate org::bukkit::entity::Zombie
  
  predicate org::bukkit::entity::WaterMob
  predicate org::bukkit::entity::Squid
  
  predicate org::bukkit::entity::Player

  predicate org::bukkit::entity::PoweredMinecart
  predicate org::bukkit::entity::LightningStrike 
  predicate org::bukkit::entity::Boat
  predicate org::bukkit::entity::StorageMinecart
  predicate org::bukkit::entity::FallingSand
  predicate org::bukkit::entity::Explosive
  predicate org::bukkit::entity::Painting
  predicate org::bukkit::entity::Egg
  predicate org::bukkit::entity::Fireball
  predicate org::bukkit::entity::Vehicle
  predicate org::bukkit::entity::ExperienceOrb
  predicate org::bukkit::entity::Snowball
  predicate org::bukkit::entity::Projectile
  predicate org::bukkit::entity::Arrow
  predicate org::bukkit::entity::TNTPrimed, :tnt_primed
  predicate org::bukkit::entity::Minecart
  predicate org::bukkit::entity::Weather
  
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

