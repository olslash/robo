# register controller
# unregister controller
# get controller by id
# get all ships

class PlayerManager
  constructor: (@game) ->
    @connectedPlayers = {}

  registerController: (controllerId) ->
    if @game.state.current is 'ConnectControllers' # todo: put this logic somewhere else
      @connectedPlayers[controllerId] = {
        connected: true,
        ship: {}
      }

  unregisterController: (controllerId) ->
    @connectedPlayers[controllerId]?.ship.destroy?(true, true)
    delete @connectedPlayers[controllerId]

  registerShip: (shipInstance, {controllerId}) ->
    if @game.state.current is 'ConnectControllers' # todo: put this logic somewhere else
      @connectedPlayers[controllerId].ship = shipInstance

module.exports = PlayerManager
