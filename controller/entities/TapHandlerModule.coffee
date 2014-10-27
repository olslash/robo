Module = require '../../game/entities/Module'

class TapHandlerModule extends Module
  constructor: (@game, {@onTapAction, @positionInstalledInShip}) ->
    super(@game, 'green32')
    @energyRequired = 0

    @inputEnabled = true # tells Phaser to watch for input events on this sprite
    @canActivate = true
  doAction: ->
    @onTapAction(this)

  update: ->
    if @canActivate and @input.pointerDown()
      @doAction()
      @canActivate = false # prevent a call every frame if button held

    if not @canActivate and @input.pointerUp()
      @canActivate = true



module.exports = TapHandlerModule
