class Ship extends Phaser.Sprite
  constructor: (@game, x, y) ->
    super(@game, x, y, 'grid96', 0)

    @energyRemaining = 100
    @maxThrust = 0
    @turnRate = 15

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
    cardinal = to
    @moduleSlots[x][y]?.orientTo(cardinal)

  moduleSlotIsFreeAndValid: (x, y) ->
    return true if @schema[x][y] is true and not @moduleSlots[x][y]
    false

  canSupportModule: (module)->
    @energyRemaining > module.energyRequired

  getSlotPixelCoordinates: (x, y) ->
    # todo: needs to work for ship configurations other than 96x96
    # 0: -32
    # 1: 0
    # 2: 32

    pixelX = -32
    pixelY = -32

    [pixelX + (x * 32), pixelY + (y * 32)]

  updateControlState: (state) ->

  update: ->
    for row in @moduleSlots
      for module in row
        module?.update()
    return true # coffeescript does some crazy stuff if I don't do this

#    if (@game.cursors.left.isDown)
#      @body.rotateLeft(@turnRate)
#    else if (@game.cursors.right.isDown)
#      @body.rotateRight(@turnRate)
#    else
#      @body.setZeroRotation()
#
#    if (@game.cursors.up.isDown)
#      console.log('thrust', @maxThrust)
#      @body.thrust(@maxThrust)
#    else if (@game.cursors.down.isDown)
#      @body.reverse(@maxThrust)





module.exports = Ship
