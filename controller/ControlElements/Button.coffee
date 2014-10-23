ControlElement = require './ControlElement'

class Button extends ControlElement
  constructor: (@text) ->
    super()

    @id = null

    @controlState = {
      pressed: false
    }
