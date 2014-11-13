ControlElement = require './ControlElement'

class Button extends ControlElement
  constructor: () ->
    super()

    @controlState = {
      down: false
    }

  render: ->
    @el =
          """
          <div id="#{@id}" class="button">
            this is a button
          </div>
          """
    super()



module.exports = Button
