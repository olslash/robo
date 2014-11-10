globalEmitter = require './globalEmitter'
socketRouter = require './socketRouter'
io = require('socket.io')(8000)

console.log 'server listening for socket connections on 8000'

activeGames = {}

io.on 'connection', (socket) ->
  socket.on 'register-controller', (gameCode) ->
    # this socket is a controller
    # match the gameCode to a socketRouter instance and register this
    # socket as a controller for that ame.
    if(gameCode of activeGames)
      activeGames[gameCode].assignControllerSocket(socket)
      socket.emit 'gamecode-ok'
    else socket.emit 'gamecode-bad'

  socket.on 'register-game', (gameCode) ->
    # this socket is a game
    # create a new socketRouter and assign this socket to its gameSocket
    activeGames[gameCode] = new socketRouter(gameCode)
    activeGames[gameCode].assignGameSocket(socket)

  socket.on 'error', (error) ->
    console.log 'socket error!', error

globalEmitter.on 'game-ended', (gameCode) ->
  delete activeGames[gameCode]
