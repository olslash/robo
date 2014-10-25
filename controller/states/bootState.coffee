sceneHelpers = require '../helpers/sceneHelpers'

Boot = new Phaser.State()

Boot.preload = ->

Boot.create = ->
  @game.scale.scaleMode = Phaser.ScaleManager.SHOW_ALL
  @game.scale.enterIncorrectOrientation.add(sceneHelpers.enterIncorrectOrientationHandler, @game)
  @game.scale.leaveIncorrectOrientation.add(sceneHelpers.leaveIncorrectOrientationHandler, @game)
  @game.scale.forceOrientation(true, false) #, 'orientationImage')

  @game.state.start 'Preloader'

module.exports = Boot
