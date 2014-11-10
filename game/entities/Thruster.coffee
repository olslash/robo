Module = require './Module'
Button = require '../../controller/ControlElements/Button'

class Thruster extends Module
  constructor: (@game) ->
    super(@game, asset: 'thruster', moduleName: 'thruster')
#    @control = new Button("hi mom")
    @energyRequired = 75

    @thrustModifier = 100

  doSetup: (@ship) ->
    @_setupParticleEmitter()

    # instead, thruster itself should listen to control signals from the ship. thrust applied to module. should work
    # better for off-balance thrust and positioning
#    @ship.maxThrust += @thrustModifier

  doTeardown: (@ship) ->
    @_destroyParticleEmitter()
#    @ship.maxThrust -= @thrustModifier

  doAction: ->
    # some kind of afterburner i guess

  update: ->
    @_emitThrustParticle()

# HELPERS ================================================

  _setupParticleEmitter: ->
    @emitter = @game.add.emitter(0, 0, 1000)
    @emitter.makeParticles('blue32')
    @emitter.lifespan = 200
    @emitter.gravity = 0
    @emitterTarget = new Phaser.Point(100, 100)

  _destroyParticleEmitter: ->
    @emitter.destroy()

  _emitThrustParticle: ->
    @emitterTarget.x = @world.x
    @emitterTarget.y = @world.y
    @emitterTarget.rotate(@world.x, @world.y, @angle - 90, true, -100)
    xDistToShip = @emitterTarget.x - @world.x
    yDistToShip = @emitterTarget.y - @world.y
    @emitter.maxParticleSpeed.setTo(xDistToShip * 3, yDistToShip * 3)
    @emitter.minParticleSpeed.setTo(xDistToShip * 1, yDistToShip * 1)
    @emitter.x = @world.x
    @emitter.y = @world.y + 20
  #    @emitter.start(true, 2000, null, 1)

module.exports = Thruster
