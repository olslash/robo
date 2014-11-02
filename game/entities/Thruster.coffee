Module = require './Module'
Button = require '../../controller/ControlElements/Button'

class Thruster extends Module
  constructor: (@game) ->
    super(@game, asset: 'thruster')
#    @control = new Button("hi mom")
    @energyRequired = 75

    @thrustModifier = 100

  doSetup: (@ship) ->
    # instead, thruster itself should listen to control signals from the ship. thrust applied to module. should work
    # better for off-balance thrust and positioning
#    @ship.maxThrust += @thrustModifier

  doTeardown: (@ship) ->
#    @ship.maxThrust -= @thrustModifier

  doAction: ->
    # some kind of afterburner i guess

module.exports = Thruster
