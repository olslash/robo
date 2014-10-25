Module = require './Module'
Button = require '../../controller/ControlElements/Button'

class Thruster extends Module
  constructor: (@game) ->
    super(@game, 'cyan32')
#    @control = new Button("hi mom")
    @energyRequired = 10

    @thrustModifier = 100

  doSetup: (@ship) ->
    @ship.maxThrust += @thrustModifier

  doTeardown: (@ship) ->
    @ship.maxThrust -= @thrustModifier

  doAction: ->
    # some kind of afterburner i guess

module.exports = Thruster
