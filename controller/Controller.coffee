Hammer = require 'hammerjs'
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









# todo: organize all this junk

dist = (point1, point2) ->
  # [x, y]
  xs = point2[0] - point1[0]
  xs *= xs

  ys = point2[1] - point1[1]
  ys *= ys

  return Math.sqrt(xs + ys)

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


  stickEl = document.getElementById('stick')
  stickMoveLimit = 50;
  transition = "all .3s"

  mc = new Hammer(stickEl)

  mc.on "pan", (ev) ->
    stickEl.style.transition = "" # clear transition while dragging

    # pointer position
    pointerX =  ev.deltaX
    pointerY =  ev.deltaY

    pointerDist = Math.sqrt(pointerX*pointerX + pointerY*pointerY) # distance of pointer from origin
    normVec = [pointerX/pointerDist, pointerY/pointerDist] # normalized vector to pointer

    if pointerDist > stickMoveLimit then pointerDist = stickMoveLimit # clamp to bounds

    # move div
    stickEl.style.left = (normVec[0] * pointerDist) + "px"
    stickEl.style.top = (normVec[1] * pointerDist) + "px"

  mc.on "panend", (ev) ->
    stickEl.style.WebkitTransition = transition
    stickEl.style.MozTransition = transition

    stickEl.style.left = '0px'
    stickEl.style.top = '0px'

