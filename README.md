# Purugin - Ruby Plugins for Minecraft + Bukkit

Purugin is a plugin framework which sites on top of Bukkit that allows you to
write plugins in a Ruby syntax.

Once you copy Purugin.jar into your plugins directory you only need to drop
.rb files into your plugins directory.  If they contain code which includes
Purugin::Plugin, then they will load and get registered as Bukkit plugins.

## Example

Here is a plugin which gets registered as a plugin in Bukkit which tells
every use in the players world when a player joins or quits the world:

```ruby
#--------- examples/player_joined_full_class.rb ----------
class PlayerJoinedPlugin
  include Purugin::Plugin, Purugin::Colors
  description 'PlayerJoined', 0.1
  
  def on_enable
    # Tell everyone in players world that they have joined
    event(:player_join) do |e|
      e.player.world.players.each do |p| 
        p.msg red("Player #{e.player.name} has joined")
      end
    end

    # Tell everyone in players world that they have quit
    event(:player_quit) do |e|
      e.player.world.players.each do |p| 
        p.msg red("Player #{e.player.name} has quit")
      end
    end
  end
end
```

### Plugin Dependencies

Plugins can depend on other plugins.  There are multiple ways of accessing 
dependent plugins.  The first is to declare your plugin dependencies at the top
of your Purugin:

```ruby
    class PortsPlugin
      include Purugin::Plugin, Purugin::Colors
      description 'Ports', 0.3
      required :LocsPlus, :include => :CoordinateEncoding
      #...
    end
```

This example shows that the 'Ports' plugin requires (via 'required' method) 
 the 'LocsPlus' plugin and that it should include the 'CoordinateEncoding' module from the 'LocsPlus' plugin.

You can specify optional dependencies via the optional declaration:

```ruby
    optional :Permissions
```

As a side-effect both required and optional will define a method by the same 
name as plugin being referenced (Note: This may change since plugin names may 
not conform to sane Ruby-naming and some people don't like methods like 
'Permissions()').

A second way to get a live reference to a plugin is to ask the plugin manager:

```ruby
    plugin_manager['Permissions']
```

This has the advantage that a plugin can be named anything and you will still 
be able to reference it.

## Running

To run Purugin, you just copy Purugin.jar into your plugins directory like any 
other minecraft plugin.  Once running you can write Purugins and copy 
those .rb files into your plugins directory.  Simple!  

bin/run.sh and bin/run.bat are provided with defaults that I use and it also sets a local GEM_HOME:

```text
GEM_HOME=./gems java -Xms1024M -Xmx1024M -jar craftbukkit.jar
```
## Building Purugin locally

1. Install maven 3
2. Invoke: `mvn clean package`

## Other Novelties

[[https://github.com/enebo/Purugin/wiki/Purogo-Introduction]] - A 3D Logo implementation in Purugin.

## Contributors

`git shortlog -s -n`

    199  Thomas E. Enebo
     14  Thomas E Enebo
     10  Eric Anderson
      7  Marv Cool
      6  Thomas Dervan
      4  Humza
      3  aumgn
      2  mml
      1  Tom Dervan
      1  chase4926
