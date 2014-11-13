ControlElement = require './ControlElement'

class Button extends ControlElement
  constructor: () ->
    super()

    @el =
          """
          <div id="#{@id}" class="button">
            this is a button
          </div>
          """

    @controlState = {
      down: false
    }

  render: ->
    super()



module.exports = Button
