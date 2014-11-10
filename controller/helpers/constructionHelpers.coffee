TapHandlerModule = require '../entities/TapHandlerModule'

module.exports.fillShipWithTapHandlerModules = (game, ship, params) ->
  for row, x in ship.schema
    for moduleSlot, y in row
      if moduleSlot == true
        params.positionInstalledInShip = [x, y]
        newModule = new TapHandlerModule(game, params)
        ship.installModule(newModule, x, y)
  return true