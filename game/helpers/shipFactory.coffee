entitiesData = require './allEntities.coffee'

class shipFactory
#  constructor: (@game) ->
  setGame: (@game) ->

  makeShip: (shipModelName, x, y, game) ->
    if shipClass = entitiesData.ships[shipModelName]
      return new shipClass(@game, x, y)
    else
      console.log 'error: not a valid ship model'

  deserialize: (serializedShipData) ->
    shipData = JSON.parse(serializedShipData)
    shipModelName = shipData.shipModelName

    if shipClass = entitiesData.ships[shipModelName]
      ship = new shipClass(@game, 0, 0)

      console.log shipData
      for modulePosition of shipData.modules
        [x, y] = modulePosition.split(',')

        thisModule = shipData.modules[modulePosition]
        orientation = thisModule.orientation
        type = thisModule.type

        if moduleClass = entitiesData.modules[type]
          moduleToInstall = new moduleClass(@game)
          ship.installModule(moduleToInstall, x, y)
          ship.orientModuleAt(x, y, to: orientation)
        else
          console.log 'deserializing error: invalid module name'

      return ship
    else
      console.log 'deserializing error: invalid ship type'


module.exports = new shipFactory()