class ControlElement
  constructor: (@text) ->
    @text or= "button"
    @id = null
    @el = null
    @htmlClass = "button"
    @controlState = {}

  render: ->
    if @id
      @el = "<div id=\"#{@id}\" class=\"#{@htmlClass}\">#{@text}</div>"
    else
      console.log 'button needs a div ID before it can render'
