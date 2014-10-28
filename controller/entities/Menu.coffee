class Menu
  constructor: (@game, {@itemSpriteSize}) ->
    @states = {}

  addState: ({id, onEnterState, onLeaveState}) ->
    @states[id] = new MenuState(@game, id, {onEnterState, onLeaveState, @itemSpriteSize})

  transitionToState: (stateName) ->
    console.log 'transition to', stateName
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
    # make a button sprite, add it to the next avialable button slot in the parent container
    # add the click callback
    buttonToAdd = new Phaser.Button(@game, 0, 0, sprite, onClick)
    @parentSprite.addChild(buttonToAdd)
    buttonToAdd.y = (@itemSpriteSize[1] * @parentSprite.children.length) - 32


  render: ({position, currentShowingData}) ->
    @parentSprite.y = position.top
    @parentSprite.x = position.left

    @parentSprite.revive()
    @isCurrentDisplayed = true
    @onEnterState?()

  hide: ->
    console.log 'kill', @id
    @onLeaveState?()
    @parentSprite.kill()
    @isCurrentDisplayed = false

module.exports = Menu
