socket = require 'socket.io-client'
ShipFactory = require '../helpers/ShipFactory'
PlayerManager = require '../helpers/PlayerManager'

ConnectControllers = new Phaser.State()

ConnectControllers.init = ->

ConnectControllers.preload = ->

ConnectControllers.create = ->
  @game.playerManager = new PlayerManager(@game)
  @game.shipFactory = new ShipFactory(@game)

  @game.gameId = @makeGameCode()
  @game.socket = socket 'http://localhost:8000'

  @startButton = @add.button(100, 100, 'green32', @startGame, this).kill()

  @game.socket.on 'connect', =>
    # show the gamecode onscreen
    text = '' + @game.gameId
    style = {font: "65px Arial", fill: "#ff0044", align: "center"}
    @game.add.text(@game.world.centerX - 100, 0, text, style);

    # notify server that a game was created
    @game.socket.emit 'register-game', @game.gameId

  @game.socket.on 'controller-connected', @game.playerManager.registerController.bind(@game.playerManager)
  @game.socket.on 'controller-disconnected', @game.playerManager.unregisterController.bind(@game.playerManager)

  # receive completed ships from players and put them into the game world
  @game.socket.on 'ship-data', (data) =>
    newShip = @game.shipFactory.deserialize(data.shipData)
    @game.playerManager.registerShip(newShip, controllerId: data.controller)
    newShip.moveTo(100, 150)
    @add.existing(newShip)


ConnectControllers.update = ->
  connectedPlayers = Object.keys(@game.playerManager.connectedPlayers)
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

ConnectControllers.startGame = ->
  @game.state.start 'Play'

ConnectControllers.makeGameCode = ->
  Math.floor(Math.random() * 99999)

module.exports = ConnectControllers

