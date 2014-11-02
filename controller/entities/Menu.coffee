class Menu
  constructor: (@game, {@itemSpriteSize}) ->
    @states = {}

  addState: ({id, onEnterState, onLeaveState}) ->
    @states[id] = new MenuState(@game, id, {onEnterState, onLeaveState, @itemSpriteSize})

  transitionToState: (stateName) ->
#    console.log 'transition to', stateName
    # does this need to be different from @show()?
    @_closeOpenState()
    @states[stateName].render({@position, @currentShowingData})

  show: ({initialState, @position, @currentShowingData}) ->
    @_closeOpenState()
    @states[initialState].render({@position, @currentShowingData})

  clear: ->
    @currentShowingData = {}
    @position = {}
    @_closeOpenState()

  _closeOpenState: ->
    # close any open state
    for state of @states
      @states[state].hide() if @states[state].isCurrentlyDisplayed


class MenuState
  # do states actually hold a container sprite and menu items?
  # then the menu class holds states and handles rendering and hiding them
  constructor: (@game, @id, {@onEnterState, @onLeaveState, @itemSpriteSize}) ->
    @parentSprite = new Phaser.Sprite(@game, 0, 0)
    @parentSprite.kill()
    @game.add.existing(@parentSprite)

    @isCurrentlyDisplayed = false

  addItem: ({type, text, sprite, onClick}) ->
    # make a button sprite, add it to the next available button slot in the parent container
    # add the click callback
    buttonToAdd = new Phaser.Button(@game, 0, 0, sprite, onClick)
    @parentSprite.addChild(buttonToAdd)
    buttonToAdd.y = (@itemSpriteSize[1] * @parentSprite.children.length) - 32
#    @clickOffListener =

  render: ({position, @currentShowingData}) ->
    [@parentSprite.y, @parentSprite.x] = [position.top, position.left]
    @parentSprite.revive()
    @isCurrentlyDisplayed = true
    @parentSprite.inputEnabled = true

    # set listener for clickaway dismiss
    setTimeout (=> # FIXME: clickaway will trigger immediately without this, but it's buggy
      @parentSprite.input.priorityID = -1 # make sure input events are handed down to child sprites
      @clickAwayListener = @game.input.onTap.add (->
        do @hide if not @parentSprite.input.checkPointerOver(@game.input.activePointer, true)
      ), this
    ), 100

    @onEnterState?()


  hide: ->
    @clickAwayListener.detach()
    @parentSprite.inputEnabled = false

    @onLeaveState?()
    @parentSprite.kill()
    @isCurrentlyDisplayed = false

module.exports = Menu
