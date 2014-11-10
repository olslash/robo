assets = require('../../game/assets/preload')('controller')

Preloader = new Phaser.State()

Preloader.preload = ->
  for name, path of assets
    @game.load.image(name, path)

Preloader.create = ->
  @game.state.start 'Construct'

module.exports = Preloader
