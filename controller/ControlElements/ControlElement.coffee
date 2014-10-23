class ControlElement
  constructor: (@text) ->
    @id = null
    @el = null
    @htmlClass = "button"
    @text = "button"
    @controlState = {}

  render: ->
    if @id
      @el = "<div id=\"#{@id}\" class=\"#{@htmlClass}\">#{@text}</div>"
    else
      console.log 'button needs a div ID before it can render'
