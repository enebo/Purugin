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

<pre><code>
--------- examples/player_joined_full_class.rb ----------
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
end
</code></pre>

### Plugin Dependencies

Plugins can depend on other plugins.  There are multiple ways of accessing 
dependent plugins.  The first is to declare your plugin dependencies at the top
of your Purugin:

<pre><code>
class PortsPlugin
  include Purugin::Plugin, Purugin::Colors
  description 'Ports', 0.3
  required :LocsPlus, :include => :CoordinateEncoding
  #...
end
</code></pre>

This example shows that the 'Ports' plugin requires (via 'required' method) 
 the 'LocsPlus' plugin and that it should include the 'CoordinateEncoding' module from the 'LocsPlus' plugin.

You can specify optional dependencies via the optional declaration:

<pre><code>
optional :Permissions
</code></pre>

As a side-effect both required and optional will define a method by the same 
name as plugin being referenced (Note: This may change since plugin names may 
not conform to sane Ruby-naming and some people don't like methods like 
'Permissions()').

A second way to get a live reference to a plugin is to ask the plugin manager:

<pre><code>
plugin_manager['Permissions']
</code></pre>

This has the advantage that a plugin can be named anything and you will still 
be able to reference it.

## Running

If you used the install script (requires a Ruby interpreter >1.9.1), then
all you need to do is execute the run.sh or run.bat script which gets put
into your minecraft directory.

If you want to do this manually, then you will need to:
1. Have jruby-complete.jar from www.jruby.org/downloads in your Minecraft directory.
2. java -Xms1024M -Xmx1024M -cp jruby-complete.jar:craftbukkit-0.0.1-SNAPSHOT.jar org.bukkit.craftbukkit.Main

