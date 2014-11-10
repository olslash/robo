assets = require('../assets/preload')('game')

Preloader = new Phaser.State()

Preloader.preload = ->
  for name, path of assets
    @game.load.image(name, path)

Preloader.create = ->
  @game.state.start 'ConnectControllers'

module.exports = Preloader
