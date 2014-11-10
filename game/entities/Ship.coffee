class Ship extends Phaser.Sprite
  constructor: (@game, x, y, {@shipModelName, sprite} = {}) ->
    @shipModelName ?= 'base'
    sprite ?= 'grid96'
    super(@game, x, y, sprite, 0)

    @energyRemaining = 1000
#    @maxThrust = 0
#    @turnRate = 15

    @schema = [[true, true, true],
              [true, true, true],
              [true, true, true]]
    @moduleSlots = [[], [], []]

    @anchor.setTo(0.5, 0.5)
    @scale.setTo(1, 1)

    @game.physics.p2?.enable(this)

  installModule: (module, x, y) ->
    if @moduleSlotIsFreeAndValid(x, y) and @canSupportModule(module)
      @moduleSlots[x][y] = module
      
      slotPixelCoordinates = @getSlotPixelCoordinates(x, y)
      module.moveTo(slotPixelCoordinates[0], slotPixelCoordinates[1])

      @game.add.existing(module)
      @addChild(module)

      module.doSetup(this)
      @energyRemaining -= module.energyRequired
      return true

    return false

  removeModuleAt: (x, y) ->
    @moduleSlots[x][y].doTeardown(this)
    @energyRemaining -= @moduleSlots[x][y].energyRequired
    @moduleSlots[x][y].destroy()
    @moduleSlots[x][y] = null

  # takes N, E, S, W for 'to'
  orientModuleAt: (x, y, {to}) ->
    @moduleSlots[x][y]?.orientTo(to)

  moduleSlotIsFreeAndValid: (x, y) ->
    return true if not @moduleSlots[x]?[y] and @schema[x]?[y] is true
    false

  canSupportModule: (module)->
    @energyRemaining > module.energyRequired

  getSlotPixelCoordinates: (x, y) ->
    console.log 'getpixel'
    # assumes always an odd number of rows and columns
    # (so that anchor at 0.5/0.5 always works easily)
    numColumns = @schema[0].length
    numRows = @schema.length

    medianColumn = Math.floor (numColumns + 1) / 2
    medianRow = Math.floor (numRows + 1) / 2

    pixelX = (numRows - medianRow) * -32
    pixelY = (numColumns - medianColumn) * -32

    #fixme-- why does this have to be flipped??
    return [pixelY + (y * 32), pixelX + (x * 32)]

  moveTo: (x, y) ->
    [@x, @y] = [x, y]

  updateControlState: (state) ->

  update: ->
    for row in @moduleSlots
      for module in row
        module?.update()
    return true # coffeescript does some crazy stuff if I don't do this

  serialize: ->
    shipData = {
      shipModelName: @shipModelName
      modules: {}
    }

    for row, x in @moduleSlots
      for module, y in row
        shipData.modules[x + ',' + y] = module?.serialize()

    return JSON.stringify(shipData)

module.exports = Ship
