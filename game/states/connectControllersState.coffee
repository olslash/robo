socket = require 'socket.io-client'
shipFactory = require '../helpers/shipFactory'

ConnectControllers = new Phaser.State()

ConnectControllers.init = ->

ConnectControllers.preload = ->

ConnectControllers.create = ->
  shipFactory.setGame(@game)

  @game.connectedControllers = {}
  @game.gameId = @makeGameCode()
  @game.socket = socket 'http://localhost:8000'

  @game.socket.on 'connect', =>
    # show the gamecode onscreen
    text = '' + @game.gameId
    style = {font: "65px Arial", fill: "#ff0044", align: "center"}
    @game.add.text(@game.world.centerX - 100, 0, text, style);

    # notify server that a game was created
    @game.socket.emit 'register-game', @game.gameId

  # receive completed ships from players and put them into the game world
  @game.socket.on 'ship-data', (data) =>
    newShip = shipFactory.deserialize(data.shipData)
    @game.connectedControllers[data.controller].ship = newShip
    newShip.moveTo(100, 150)
    @add.existing(newShip)


  @game.socket.on 'controller-connected', @registerController.bind(this)
  @game.socket.on 'controller-disconnected', @unregisterController.bind(this)

  @startButton = @add.button(100, 100, 'green32', @startGame, this).kill()


ConnectControllers.update = ->
  connectedPlayers = Object.keys(@game.connectedControllers)
  @updatePlayersConnectedText(connectedPlayers.length)


ConnectControllers.updatePlayersConnectedText = (numConnectedPlayers) ->
  if not @playersConnectedText
    text = numConnectedPlayers + ' players connected'
    style = { font: "32px Arial", fill: "#ff0044", align: "center" }
    @playersConnectedText = @game.add.text(@game.world.centerX - 150, 100, text, style)

  @playersConnectedText.setText(numConnectedPlayers + ' players connected')

  if numConnectedPlayers > 0 and not @startButton.exists
    @startButton.revive()
  else if numConnectedPlayers == 0 and @startButton.exists
    @startButton.kill()

ConnectControllers.registerController = (controllerId) ->
  @game.connectedControllers[controllerId] = {
    connected: true,
    ship: {}
  }

ConnectControllers.unregisterController = (controllerId) ->
  delete @game.connectedControllers[controllerId]

ConnectControllers.startGame = ->
#  @game.state.start 'Play'

ConnectControllers.makeGameCode = ->
  Math.floor(Math.random() * 99999)

module.exports = ConnectControllers

