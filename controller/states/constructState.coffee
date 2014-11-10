shipFactory         = require('../../game/helpers/shipFactory')
Module              = require '../../game/entities/Module'
TapHandlerModule    = require '../../controller/entities/TapHandlerModule'
constructionHelpers = require '../helpers/constructionHelpers'
constructionMenu    = require '../entities/constructionMenu'

Construct = new Phaser.State()

Construct.preload = ->

Construct.create = ->
#  @game.physics.startSystem(Phaser.Physics.P2JS)
  #  @game.physics.p2.defaultRestitution = 0.8;
  #  console.log @game.cache.getImage('blue32').naturalHeight
  shipFactory.setGame(@game)
  shipPosition = {x: @game.width/2 + 100, y: @game.height/2}

  @modelShip = shipFactory.makeShip('wedge', shipPosition.x, shipPosition.y)
  @touchCaptureShip = shipFactory.makeShip('wedge', shipPosition.x, shipPosition.y)

  @modelShip.scale.setTo(2, 2)
  @touchCaptureShip.scale.setTo(2, 2)

  @touchCaptureShip.alpha = 0.2
  @touchCaptureShip.bringToTop()
#  # fill the capture ship with "modules" that open the installation menu
  constructionHelpers.fillShipWithTapHandlerModules(@game, @touchCaptureShip,
    {onTapAction: @openMenu.bind(this)})
#
  @add.existing(@modelShip)
  @add.existing(@touchCaptureShip)
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


Construct.render = ->
#  @game.debug.pointer(@game.input.mousePointer)
#  @game.debug.pointer(@game.input.pointer1)



module.exports = Construct
