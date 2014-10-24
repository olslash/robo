helpers = require '../helpers/helpers'

Boot = new Phaser.State()

Boot.preload = ->

Boot.create = ->
  @game.scale.scaleMode = Phaser.ScaleManager.SHOW_ALL
  @game.scale.enterIncorrectOrientation.add(helpers.enterIncorrectOrientationHandler, @game)
  @game.scale.leaveIncorrectOrientation.add(helpers.leaveIncorrectOrientationHandler, @game)
  @game.scale.forceOrientation(true, false) #, 'orientationImage')

  @game.state.start 'Preloader'

module.exports = Boot
