Play = new Phaser.State()

Play.create = ->
  console.log @game.playerManager
  for _, player of @game.playerManager.connectedPlayers
#    player.ship.game = @game
#    console.log player.ship
    @game.add.existing(player.ship)
module.exports = Play
