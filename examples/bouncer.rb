class BouncerPlugin
  include Purugin::Plugin
  description 'Bouncer', 0.2

  class FlightInfo
    INCREMENT = 0.1
    MAX_HEIGHT = 2.0

    attr_accessor :height, :falling

    def initialize
      @height, @falling = 0.0, false
    end

    def higher!
      @height += INCREMENT if @height < MAX_HEIGHT
      @falling = true
      @height
    end
  end

  def on_enable
    players = {}

    event(:entity_damage) do |e| # Done falling: don't take damage
      e.cancelled = true if players[e.entity] && players[e.entity].falling
    end

    event(:player_move) do |e|
      player = e.player
      loc = org.bukkit.Location.new player.world, e.to.x, e.to.y - 0.5, e.to.z
      
      if loc.block.is? :ice # Take off
        players[player] = FlightInfo.new unless players[player]
        players[player].higher!
        p player.location.direction
        player.velocity = player.location.direction.multiply(0.2).tap do |dir|
          dir.y = players[player].height
        end
        player.fall_distance = 0
      elsif players[player] && players[player].falling
        if !loc.block.is?(:air, :ice)  # not a bouncy thing. stop.
          players.delete(player)
          player.fall_distance = 0
        end
      end
    end
  end
end
