globalEmitter = require './globalEmitter'
# represents routing between the controllers for to a single game,
# and the game itself.

class SocketRouter
  constructor: (@gameCode) ->
    @gameSocket = null
    @controllerSockets = []

  assignControllerSocket: (socket) ->
    # controllerIndex = this.controllerSockets.indexOf(socket);
    if socket not in @controllerSockets
      console.log(@gameCode, 'controller connected')
      
      @controllerSockets.push(socket)

      #notify the game that a controller has connected
      @gameSocket.emit 'controller-connected', socket.id

      socket.on 'ship-data', (data) =>
        # player has finished building their ship and has sent it to the server-- forward it to the game
        @gameSocket.emit 'ship-data', {controller: socket.id, shipData: data}

      socket.on 'control-update', (data) =>
        # controller updates with its state
        # (buttons, analog inputs, etc)
        # console.log(this.gameCode, 'got control update', data)
        @gameSocket.emit 'control-update', {controller: socket.id, state: data}

      socket.on 'disconnect', () =>
        @removeControllerSocket socket

  removeControllerSocket: (socket) ->
    if socket in @controllerSockets
      @gameSocket.emit 'controller-disconnected', socket.id
      @controllerSockets.splice(@controllerSockets.indexOf(socket), 1)

  assignGameSocket: (socket) ->
    if @gameSocket is null
      @gameSocket = socket

      socket.on 'disconnect', =>
        @cleanUp()
        globalEmitter.emit 'game-ended', @gameCode

  cleanUp: ->
    socket.disconnect() for socket in @controllerSockets
    @controllerSockets = []
    @gameSocket = null

module.exports = SocketRouter
