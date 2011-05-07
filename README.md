# Purugin - Ruby Plugins for Minecraft + Bukkit

Purugin is a plugin framework which sites on top of Bukkit that allows you to
write plugins in a Ruby syntax.

Once you copy Purugin.jar into your plugins directory you only need to drop
.rb files into your plugins directory.  If they contain code which includes
Purugin::Plugin, then they will load and get registered as Bukkit plugins.

When I started this plugin I thought it would be fairly straight-forward. In
respect to basic methods like onEnable it has been.  Overall, it has been a
huge voyage of discovery.  I did not know Bukkit at all when I started (and
I really just started) and limitations combined with lessons learned makes
me think the API will be changing over time.  So write plugins but be 
forewarned, they may change here and there....

## Example

Here is a plugin which gets registered as a plugin in Bukkit which tells
every use in the players world when a player joins or quits the world:

``--------- player_joined.rb ----------
class PlayerJoinedPlugin
  include Purugin::Plugin
  description 'PlayerJoined', 0.1
  
  def on_enable
    # Tell everyone in players world that they have joined
    event(:player_join) do |e|
      e.player.world.players.each do |p| 
        p.send_message "Player #{e.player.name} has joined"
      end
    end

    # Tell everyone in players world that they have quit
    event(:player_quit) do |e|
      e.player.world.players.each do |p| 
        p.send_message "Player #{e.player.name} has quit"
      end
    end
  end
end``

### Load plugins

If you want to include an module into your plugin you can add a line in
on_enable like:

``def on_enable
  include_plugin_module 'Commands', 'Command'
  # .... use methods from Command module now
end``

This example shows this method include the Command module defined in the 
Commands plugin into it. 

## Running

Unfortunately, there is some weird Java Classloader interaction between JRuby
and CraftBukkit.  To start up Craftbukkit with Purugin, you need to do a couple
of extra things:

1. Have jruby-complete.jar from www.jruby.org/downloads in your Craftbukkit directory.
2. java -Xms1024M -Xmx1024M -cp jruby-complete-0.6.1.jar:craftbukkit-0.0.1-SNAPSHOT.jar org.bukkit.craftbukkit.Main

Not ideal, but not particularly difficult either...
