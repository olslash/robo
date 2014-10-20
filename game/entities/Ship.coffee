class Ship extends Phaser.Sprite
  constructor: (@game, x, y) ->
    super(@game, x, y, 'grid96', 0)

    @modules = [[], [], []]

    @energyRemaining = 100

    @anchor.setTo(0.5, 0.5)
    @scale.setTo(1, 1)

    @game.physics.enable(this, Phaser.Physics.ARCADE)

  installModule: (module, x, y) ->
    if @moduleSlotIsFree(x, y) and @canSupportModule(module)
      @modules[x][y] = module
      
      slotPixelCoordinates = @getSlotPixelCoordinates(x, y)

      module.moveTo(slotPixelCoordinates[0], slotPixelCoordinates[1])

      @game.add.existing(module)
      @addChild(module)
      return true

    return false

  moduleSlotIsFree: (x, y) ->
    return true if @modules[x][y] is undefined
    false

  canSupportModule: ->
    return true # check energy or whatever

  getSlotPixelCoordinates: (x, y) ->
    # 0: -32
    # 1: 0
    # 2: 32

    pixelX = -32
    pixelY = -32

    [pixelX + (x * 32), pixelY + (y * 32)]

  updateControlState: (state) ->

  update: ->
    for row in @modules
      for module in row
        module?.update()


    if @game.input.mousePointer.isDown
      @game.physics.arcade.moveToPointer(this, 400);
    else
      @body.velocity.setTo(0, 0);

module.exports = Ship
