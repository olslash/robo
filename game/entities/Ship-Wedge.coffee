Ship = require './Ship'

class WedgeShip extends Ship
  constructor: (@game, x, y) ->
    @shipModelName = 'wedge'
    super(@game, x, y, shipModelName: 'wedge', sprite: 'wedgeship')

    @energyRemaining = 1000

    @schema = [[false, false, true, false, false],
              [false, true, true, true, false],
              [true, true, true, true, true]]

    @moduleSlots = [[], [], []]

    @anchor.setTo(0.5, 0.5)
    @scale.setTo(1, 1)

    @game.physics.p2?.enable(this)

  updateControlState: (state) ->


module.exports = WedgeShip
