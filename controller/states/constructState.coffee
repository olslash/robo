Ship     = require '../../game/entities/Ship'
Thruster = require '../../game/entities/Thruster'
Module   = require '../../game/entities/Module'

Construct = new Phaser.State()

Construct.preload = ->

Construct.create = ->
  @doThingButton = @add.button(100, 100, 'blue32', @testModule, this)
  @doThing2Button = @add.button(100, 200, 'orange32', @test2Module, this)
  @doThing3Button = @add.button(100, 250, 'red32', @test3Module, this)

  @game.physics.startSystem(Phaser.Physics.P2JS)
  @game.physics.p2.defaultRestitution = 5.0;
  @ship = new Ship(@game, 100, 100)
  
  @game.add.existing(@ship)

  @game.cursors = @game.input.keyboard.createCursorKeys()

Construct.testModule = ->
  aModule = new Thruster(@game)
  @ship.installModule(aModule, 0, 0)

Construct.test2Module = ->
  aModule = new Thruster(@game)
  @ship.installModule(aModule, 1, 0)

Construct.test3Module = ->
  aModule = new Thruster(@game)
  @ship.installModule(aModule, 0, 2)

module.exports = Construct
