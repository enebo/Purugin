require 'delegate'

# Several types of plugins revolve around giving the players extra abilities.
# The idiom for providing these abilities typically will involve having a live
# object you can lookup and use for that player while they are logged in.
#
# This Purugin shows a simple mechanism using the delegate library to do just
# that.  
class ExtendPlayerPlugin
  include Purugin::Plugin
  description 'ExtendPlayer', 0.1

  # Personality is extra behavior we will be attaching to the player we
  # pass into Personality's constructor.
  class Personality < SimpleDelegator
    include Purugin::Colors

    def initialize(player)
      super(player)
    end

    # Simple example of behavior we are adding to this personality
    # Notice this is calling Player.msg because we are delegating through
    # the player we passed in.
    def say_it_red(message)
      msg red(message)
    end
  end
  
  def on_enable
    # Live storage of personalities
    personalities = {}
    
    player_command('add_pers', 'Give user extended pers.') do |me, *|
      personality = personalities[me.name]
      if personality
        me.msg "You already have a personality"
      else
        personalities[me.name] = Personality.new me
        me.msg "You now have a personality"
      end
    end
    
    player_command('remove_pers', 'Remove users extended pers.') do |me, *| 
      personality = personalities[me.name]
      if personality
        personalities[me.name] = nil
        me.msg "You no longer have a personality"
      else
        me.msg "You already do not have a personality"
      end
    end

    player_command('show_pers', 'Show users extended pers.') do |me, *args|
      personality = personalities[me.name]
      if personality
        personality.say_it_red args.join(' ')
      else
        me.msg "You need to do /add_pers to call this"
      end
    end
  end
end
