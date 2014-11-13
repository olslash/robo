# a control is a dom element, dynamically added to the html controller as modules are added to the ship.
# the element itself is loaded from a partial
# in doSetup, we should call some method to inject the element into the dom
# when an element is instanciated, it gets a unique ID that can be tied to its particular module instance
# need a controller class which abstracts the construction of a controller in the dom by taking in controlelements

class ControlElement
  constructor: () ->
    @el = "" # must be overridden by subclass
    @id = -1 # will be set by the controller class on install
    @controlState = {} # must be overridden by subclass

  render: ->
    return @el

module.exports = ControlElement
