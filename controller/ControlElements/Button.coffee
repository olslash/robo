ControlElement = require './ControlElement'

class Button extends ControlElement
  constructor: (@text) ->
    super(@text)

    @id = null

    @controlState = {
      pressed: false
    }

module.exports = Button
