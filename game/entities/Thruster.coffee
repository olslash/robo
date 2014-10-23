Module = require './Module'
Button = require '../../controller/ControlElements/Button'

class Thruster extends Module
  constructor: (@game) ->
    super(@game)
    @control = new Button()
    @energyRequired = 10

    @speedModifier = 100

  doSetup: (@ship) ->
    @ship.topSpeed += @speedModifier

  doAction: ->
    # some kind of afterburner i guess

module.exports = Thruster
