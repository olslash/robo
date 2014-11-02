Menu = require './Menu'

Thruster = require '../../game/entities/Thruster'
# need a function flow to
# > open module select menu -> pass the result of that menu (user selection)
# -> install the selected module on the ship in the location the user tapped, removing any existing module
# -> close the menu
#
# click module -> module asks ship "where am i?"

module.exports.init = (game, {context}) ->
  buildMenu = new Menu(game, {itemSpriteSize: [128, 32]}) #, top: 40, left: 40})

  notifyCantInstallModule = ->
    console.log 'cant install that module there'

  # STATES
  categorySelectState = buildMenu.addState({
    id: 'categorySelectState',
  #    onEnterState: ->
  #    onLeaveState: ->
  })

  movementSelectState = buildMenu.addState({
    id: 'movementSelectState'
  })

  orientationSelectState = buildMenu.addState({
    id: 'orientationSelectState'
  })


  # MODULE CATEGORIES
  categorySelectState.addItem({
  #    type: 'textButton',
  #    text: 'MOVEMENT',
    sprite: 'movement_button',
    onClick: =>
      buildMenu.transitionToState('movementSelectState') # states should have handlers for enter/leave
  })

  categorySelectState.addItem({
  #    type: 'textButton',
  #    text: 'WEAPONS',
    sprite: 'weapons_button',
    onClick: =>
      buildMenu.transitionToState('weaponSelectState') # states should have handlers for enter/leave
  })



  # MOVEMENT MODULES
  movementSelectState.addItem({
    sprite: 'engine_button',
  #    thumbnail: 'blue32',
    onClick: =>
      [x, y] = buildMenu.currentShowingData.modulePositionInShip
      thruster = new Thruster(game)
      if buildMenu.currentShowingData.ship.installModule(thruster, x, y)
        buildMenu.transitionToState 'orientationSelectState'
      else
        notifyCantInstallModule()
        
  })

  movementSelectState.addItem({
    sprite: 'gyro_button',
  #      thumbnail: 'blue32',
    onClick: =>
      console.log buildMenu.currentShowingData.modulePositionInShip
      # install the cannon module into the ship
  })



  # WEAPON MODULES
  weaponSelectState = buildMenu.addState({
    id: 'weaponSelectState'
  })

  weaponSelectState.addItem({
    sprite: 'laser_button',
  #    thumbnail: 'blue32',
    onClick: =>
      console.log buildMenu.currentShowingData.modulePositionInShip
      # install the cannon module into the ship
  })

  weaponSelectState.addItem({
    sprite: 'cannon_button',
  #      thumbnail: 'blue32',
    onClick: =>
      console.log buildMenu.currentShowingData.modulePositionInShip
      # install the cannon module into the ship
  })



  # MODULE ORIENTATION
  orientationSelectState.addItem({
    sprite: 'north_button'
    onClick: =>
      [x, y] = buildMenu.currentShowingData.modulePositionInShip
      buildMenu.currentShowingData.ship.orientModuleAt(x, y, to: 'n')
  })

  orientationSelectState.addItem({
    sprite: 'south_button'
    onClick: =>
      [x, y] = buildMenu.currentShowingData.modulePositionInShip
      buildMenu.currentShowingData.ship.orientModuleAt(x, y, to: 's')
  })

  orientationSelectState.addItem({
    sprite: 'east_button'
    onClick: =>
      [x, y] = buildMenu.currentShowingData.modulePositionInShip
      buildMenu.currentShowingData.ship.orientModuleAt(x, y, to: 'e')
  })

  orientationSelectState.addItem({
    sprite: 'west_button'
    onClick: =>
      [x, y] = buildMenu.currentShowingData.modulePositionInShip
      buildMenu.currentShowingData.ship.orientModuleAt(x, y, to: 'w')
  })

  return buildMenu


# final action of a button, when a module to install is ultimately selected, has to be able to consider properties of the ship.
# like an alert if the module can't be installed, or to actually install the module in the required slot

# maybe when you call the function that opens the menu, you can pass in some arbitrary data, set on that particular
# instance of the menu (cleared on close) that button callbacks can use