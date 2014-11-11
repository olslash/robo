# register controller
# unregister controller
# get controller by id
# get all ships

class PlayerManager
  constructor: (@game) ->
    @connectedControllers = {}

  registerController: (controllerId) ->
    console.log @
    @connectedControllers[controllerId] = {
      connected: true,
      ship: {}
    }

  unregisterController: (controllerId) ->
    @connectedControllers[controllerId]?.ship.destroy?()
    delete @connectedControllers[controllerId]

  registerShip: (shipInstance, {controllerId}) ->
    @connectedControllers[controllerId].ship = shipInstance

module.exports = PlayerManager
