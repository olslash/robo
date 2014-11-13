# global socket because it needs to be shared between Phaser and the controller itself
window.socket = require('socket.io-client')('http://localhost:8000')
loadGame = require './RoboPhone'
Button = require './controlElements/Button'

class Controller
  constructor: ({@socket, el: @$el}) ->
    console.log @$el
    #    @inputIds = []
    @controlState = {}

  # add a button for an installed module
  addInputModule: (controlElementInstance) ->
    #the div's id
    controlElementInstance.id = @_generateInputId()
    console.log controlElementInstance.id
    # extend our control state with the module's
    @controlState[controlElementInstance.id] = controlElementInstance.controlState
    # render the module's html and insert it into a free slot
    @$el.append(controlElementInstance.render())

  sendState:  ->
    @socket.emit('control-update', @controlState)

  _generateInputId: ->
    makeUUID = ->
      return Math.floor((1 + Math.random()) * 0x10000)
                 .toString(16)
                 .substring(1)

    makeUUID() + '_' + makeUUID() + '_' + makeUUID()










$(document).ready ->
  controller = new Controller(socket: window.socket, el: $('#controller'))
  controller.addInputModule(new Button())

  socketConnected = false

  socket.on 'connect', ->
    socketConnected = true

  $('#gamecode').submit (event) ->
    gameCode = +$('#gamecode input:first').val()

    if gameCode > 0 and socketConnected
      socket.emit('register-controller', gameCode)

    event.preventDefault()

  socket.on 'gamecode-ok', ->
    $('#register-screen').hide()
    $('#controller').show()
    loadGame()

  socket.on 'gamecode-bad', ->
    console.log 'error-- server reports game code was not recognized'
