class Menu
  constructor: (@game, {@itemSpriteSize}) ->
    # with width and height of a single menu item
    @states = {}

  addState: ({id, onEnterState, onLeaveState}) ->
    @states[id] = new MenuState(@game, id, {onEnterState, onLeaveState, @itemSpriteSize})

  transitionToState: (stateName) ->
    console.log 'transition to', stateName
    @states[stateName].render()

  show: ({initialState, position, currentShowingData}) ->
    # close any open state
    for state of @states
      @states[state].hide()

    @states[initialState].render({position, currentShowingData})



class MenuState
  # do states actually hold a container sprite and menu items?
  # then the menu class holds states and handles rendering and hiding them
  constructor: (@game, @id, {@onEnterState, @onLeaveState, @itemSpriteSize}) ->
    @parentSprite = new Phaser.Sprite(@game, 0, 0)
    @parentSprite.kill()
    @game.add.existing(@parentSprite)

    # make an invisible parent container sprite

  addItem: ({type, text, sprite, onClick}) ->
    # make a button sprite, add it to the next avialable button slot in the parent container
    # add the click callback
    buttonToAdd = new Phaser.Button(@game, 0, 0, sprite, onClick)
    @parentSprite.addChild(buttonToAdd)
    buttonToAdd.y = (@itemSpriteSize[1] * @parentSprite.children.length) - 32
#    console.log @parentSprite.children


  render: ({position, currentShowingData}) ->
    #move to position
    @parentSprite.y = position.top
    @parentSprite.x = position.left
    @parentSprite.revive()

  hide: ->
    console.log 'kill', @id
    @parentSprite.kill()

module.exports = Menu
