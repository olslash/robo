Ship     = require '../../game/entities/Ship'
Thruster = require '../../game/entities/Thruster'
Module   = require '../../game/entities/Module'
TapHandlerModule = require '../../controller/entities/TapHandlerModule'
constructionHelpers = require '../helpers/constructionHelpers'

Construct = new Phaser.State()

Construct.preload = ->

Construct.create = ->
  @doThingButton = @add.button(100, 100, 'blue32', @testModule, this)
  @doThing2Button = @add.button(100, 200, 'orange32', @test2Module, this)
#  @doThing3Button = @add.button(100, 250, 'red32', @test3Module, this)

#  @game.physics.startSystem(Phaser.Physics.P2JS)
#  @game.physics.p2.defaultRestitution = 0.8;

  @modelShip = new Ship(@game, @game.width/2, @game.height/2)
  # fill the model ship with "modules" that open the installation menu
  constructionHelpers.fillShipWithTapHandlerModules(@game, @modelShip, {onTapAction: @openModuleSelectionMenu})
  # need a function flow to
  # > open module select menu -> pass the result of that menu (user selection)
  # -> install the selected module on the ship in the location the user tapped, removing any existing module
  # -> close the menu
  #
  # click module -> module asks ship "where am i?"

  @game.add.existing(@modelShip)

#  @game.cursors = @game.input.keyboard.createCursorKeys()
#
Construct.testModule = ->
  aModule = new Thruster(@game)
  @modelShip.installModule(aModule, 0, 0)

Construct.test2Module = ->
  @modelShip.removeModuleAt(0, 0)
#  aModule = new Thruster(@game)
#  @modelShip.installModule(aModule, 1, 0)
#
#Construct.test3Module = ->
#  aModule = new Thruster(@game)
#  @modelShip.installModule(aModule, 0, 2)

Construct.render = ->
  @game.debug.pointer(@game.input.mousePointer)
  @game.debug.pointer(@game.input.pointer1)

Construct.openModuleSelectionMenu = (callingModule) ->
  [x, y] = callingModule.positionInstalledInShip
  console.log 'cool, you moused over a module installed at ', x, y

module.exports = Construct
