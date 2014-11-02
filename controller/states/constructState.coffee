Ship     = require '../../game/entities/Ship'
Module   = require '../../game/entities/Module'
TapHandlerModule = require '../../controller/entities/TapHandlerModule'
constructionHelpers = require '../helpers/constructionHelpers'
constructionMenu = require '../entities/constructionMenu.coffee'

Construct = new Phaser.State()

Construct.preload = ->

Construct.create = ->
#  @game.physics.startSystem(Phaser.Physics.P2JS)
#  @game.physics.p2.defaultRestitution = 0.8;
#  console.log @game.cache.getImage('blue32').naturalHeight
  shipPosition = {x: @game.width/2 + 100, y: @game.height/2}
  @modelShip = new Ship(@game, shipPosition.x, shipPosition.y)
  @modelShip.scale.setTo(2, 2)

  @touchCaptureShip = new Ship(@game, shipPosition.x, shipPosition.y)
  @touchCaptureShip.alpha = 0.2
  @touchCaptureShip.scale.setTo(2, 2)
  @touchCaptureShip.bringToTop()
#  # fill the capture ship with "modules" that open the installation menu
  constructionHelpers.fillShipWithTapHandlerModules(@game, @touchCaptureShip,
    {onTapAction: @openMenu.bind(this)})
#
  @game.add.existing(@modelShip)
  @game.add.existing(@touchCaptureShip)
  @selectModulesMenu = constructionMenu.init(@game, context: this)

Construct.openMenu = (callingModule) ->
  @selectModulesMenu.show({
    initialState: 'categorySelectState',

    position: {
      top: 40,
      left: 40
    },

    currentShowingData: {
      ship: @modelShip,
      shipEnergyAvailable: @modelShip.energyRemaining,
      modulePositionInShip: callingModule.positionInstalledInShip
    }
  })

# how do I check whether a given module (represented by a menu) can be installed on a ship, except for energy?
# like if I want to enforce different placement criteria by module?

# maybe the menu gets a verification function?


Construct.render = ->
#  @game.debug.pointer(@game.input.mousePointer)
#  @game.debug.pointer(@game.input.pointer1)



module.exports = Construct
