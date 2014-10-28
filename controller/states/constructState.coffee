Menu     = require '../entities/menu'
Ship     = require '../../game/entities/Ship'
Thruster = require '../../game/entities/Thruster'
Module   = require '../../game/entities/Module'
TapHandlerModule = require '../../controller/entities/TapHandlerModule'
constructionHelpers = require '../helpers/constructionHelpers'

Construct = new Phaser.State()

Construct.preload = ->

Construct.create = ->
#  @game.physics.startSystem(Phaser.Physics.P2JS)
#  @game.physics.p2.defaultRestitution = 0.8;
#  console.log @game.cache.getImage('blue32').naturalHeight
  @modelShip = new Ship(@game, @game.width/2, @game.height/2)
  # fill the model ship with "modules" that open the installation menu
  constructionHelpers.fillShipWithTapHandlerModules(@game, @modelShip,
    {onTapAction: @openModuleSelectionMenu.bind(this)})

  @game.add.existing(@modelShip)
# need a function flow to
# > open module select menu -> pass the result of that menu (user selection)
# -> install the selected module on the ship in the location the user tapped, removing any existing module
# -> close the menu
#
# click module -> module asks ship "where am i?"
  @buildMenu = new Menu(@game, {itemSpriteSize: [128, 32]}) #, top: 40, left: 40})

  categorySelectState = @buildMenu.addState({
    id: 'categorySelectState',
#    onEnterState: ->
#    onLeaveState: ->
  })
#
  categorySelectState.addItem({
#    type: 'textButton',
#    text: 'MOVEMENT',
    sprite: 'redlongbutton',
    onClick: =>
      @buildMenu.transitionToState('movementSelectState') # states should have handlers for enter/leave
  })

  categorySelectState.addItem({
#    type: 'textButton',
#    text: 'WEAPONS',
    sprite: 'yellowlongbutton',
    onClick: =>
      @buildMenu.transitionToState('weaponSelectState') # states should have handlers for enter/leave
  })
#
  movementSelectState = @buildMenu.addState({
    id: 'movementSelectState'
  })
#
  movementSelectState.addItem({
    sprite: 'brownlongbutton',
#    thumbnail: 'blue32',
    onClick: =>
      console.log @buildMenu.currentShowingData.modulePositionInShip
      # install the cannon module into the ship
  })

  movementSelectState.addItem({
      sprite: 'redlongbutton',
#      thumbnail: 'blue32',
      onClick: =>
        console.log @buildMenu.currentShowingData.modulePositionInShip
        # install the cannon module into the ship
    })



Construct.openModuleSelectionMenu = (callingModule) ->
  @buildMenu.show({
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
  @game.debug.pointer(@game.input.mousePointer)
  @game.debug.pointer(@game.input.pointer1)



module.exports = Construct
