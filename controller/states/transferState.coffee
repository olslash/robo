Transfer = new Phaser.State()

Transfer.init = ({@serializedShipData}) ->

Transfer.preload = ->

Transfer.create = ->
  # send the ship data over our socket
  window.socket.emit('ship-data', @serializedShipData)
  # local Phaser game is no longer needed-- transition to the HTML controller
  @game.destroy()
  $('canvas').hide()

Transfer.update = ->

module.exports = Transfer
