Play = new Phaser.State()

Play.create = ->
  for _, player of @game.playerManager.connectedPlayers
    @game.add.existing(player.ship)

module.exports = Play
