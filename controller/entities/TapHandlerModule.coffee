Module = require '../../game/entities/Module'

class TapHandlerModule extends Module
  constructor: (@game, {@onTapAction, @positionInstalledInShip}) ->
    super(@game, 'green32')
    @energyRequired = 0

    @inputEnabled = true

  doAction: ->
      @onTapAction(this)

  update: ->
    @doAction() if @input.pointerOver()



module.exports = TapHandlerModule
