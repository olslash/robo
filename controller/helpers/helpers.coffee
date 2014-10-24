leaveIncorrectOrientationHandler = ->
  console.log('left invalid orientation')
#  @game.scale.setMaximum()
#  @game.scale.setScreenSize(true)

enterIncorrectOrientationHandler = ->
  console.log('entered incorrect orientation')

module.exports = {
  leaveIncorrectOrientationHandler: leaveIncorrectOrientationHandler,
  enterIncorrectOrientationHandler: enterIncorrectOrientationHandler
}
