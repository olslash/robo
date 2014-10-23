Ship     = require '../entities/Ship'
Thruster = require '../entities/Thruster'
Module   = require '../entities/Module'

Construct = new Phaser.State()

Construct.preload = ->

Construct.create = ->
  @doThingButton = @add.button(100, 300, 'blue32', @testModule, this)
  @doThing2Button = @add.button(100, 350, 'orange32', @test2Module, this)
  @doThing3Button = @add.button(100, 400, 'red32', @test3Module, this)

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
