window.socket = require('socket.io-client')('http://localhost:8000')

loadGame = require './RoboPhone'

class Controller
  constructor: (@socket) ->
    @inputIds = []
    @controlState = {}
  
  # add a button for an installed module
  addInputModule: (inputModule) ->
    
    # the controller will assign a unique id, 
    inputModule.id = _generateInputId
    @controlState[inputModue.id] = inputModule.controlState
    # extend our control state with the module's

    # render the module's html and insert it into a free slot

  sendState:  ->
    @socket.emit('control-update', @controlState)

  _generateInputId: ->
    makeUUID = ->
      return Math.floor((1 + Math.random()) * 0x10000)
                 .toString(16)
                 .substring(1)

    makeUUID() + '_' + makeUUID() + '_' + makeUUID()



$(document).ready ->
  socketConnected = false

  socket.on 'connect', ->
    socketConnected = true


  $('#gamecode').submit (event) ->
    gameCode = +$('#gamecode input:first').val()

    if gameCode > 0 and socketConnected
      socket.emit('register-controller', gameCode)

    event.preventDefault()


  socket.on 'gamecode-ok', ->
    $('.register-screen').hide()
    $('.controller').show()
    loadGame()

  socket.on 'gamecode-bad', ->
    console.log 'error-- server reports game code was not recognized'


