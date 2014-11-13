# register controller
# unregister controller
# get controller by id
# get all ships

class PlayerManager
  constructor: (@game) ->
    @connectedPlayers = {}

  registerController: (controllerId) ->
    @connectedPlayers[controllerId] = {
      connected: true,
      ship: {}
    }

  unregisterController: (controllerId) ->
    @connectedPlayers[controllerId]?.ship.destroy?()
    delete @connectedPlayers[controllerId]

  registerShip: (shipInstance, {controllerId}) ->
    console.log 'instance', shipInstance
    @connectedPlayers[controllerId].ship = shipInstance

module.exports = PlayerManager
