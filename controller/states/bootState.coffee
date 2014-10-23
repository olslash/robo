Boot = new Phaser.State()

Boot.preload = ->

Boot.create = ->
  @game.state.start 'Preloader'

module.exports = Boot
