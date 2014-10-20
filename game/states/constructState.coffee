Ship = require '../entities/Ship'
Thruster = require '../entities/Thruster'
Module = require '../entities/Module'

Construct = new Phaser.State()

Construct.preload = ->

Construct.create = ->
  @doThingButton = @add.button(100, 300, 'blue32', @testModule, this)
  @doThing2Button = @add.button(100, 350, 'orange32', @test2Module, this)
  @doThing3Button = @add.button(100, 400, 'red32', @test3Module, this)

  @game.physics.startSystem(Phaser.Physics.ARCADE)
  console.log Ship
  @ship = new Ship(@game, 100, 100)
  
  @game.add.existing(@ship)

  # t = new Thruster(@game)

Construct.testModule = ->
  aModule = new Module(@game)
  @ship.installModule(aModule, 0, 0)

Construct.test2Module = ->
  aModule = new Module(@game)
  @ship.installModule(aModule, 1, 0)

Construct.test3Module = ->
  aModule = new Module(@game)
  @ship.installModule(aModule, 0, 2)
  
module.exports = Construct
