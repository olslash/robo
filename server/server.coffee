globalEmitter = require './globalEmitter'
socketRouter = require './socketRouter'
io = require('socket.io')(8000)

console.log 'server listening for socket connections on 8000'

activeGames = {}

io.on 'connection', (socket) ->

  socket.on 'registerController', (gameCode) ->
    # this socket is a controller
    # match the gameCode to a socketrouter instance and register this
    # socket as a controller.
    if(gameCode of activeGames)
      activeGames[gameCode].assignControllerSocket(socket)

  socket.on 'registerGame', (gameCode) ->
    # this socket is a game
    # create a new socketrouter and assign this socket to its gamesocket
    activeGames[gameCode] = new socketRouter(gameCode)
    activeGames[gameCode].assignGameSocket(socket)

globalEmitter.on 'game-ended', (gameCode) ->
  delete activeGames[gameCode]
