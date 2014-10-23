class Ship extends Phaser.Sprite
  constructor: (@game, x, y) ->
    super(@game, x, y, 'grid96', 0)

    @modules = [[], [], []]

    @energyRemaining = 100
    @maxThrust = 0
    @turnRate = 15

    @anchor.setTo(0.5, 0.5)
    @scale.setTo(1, 1)

    @game.physics.p2.enable(this)

  installModule: (module, x, y) ->
    if @moduleSlotIsFree(x, y) and @canSupportModule(module)
      @modules[x][y] = module
      
      slotPixelCoordinates = @getSlotPixelCoordinates(x, y)

      module.moveTo(slotPixelCoordinates[0], slotPixelCoordinates[1])

      @game.add.existing(module)
      @addChild(module)

      module.doSetup(this)
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

    if (@game.cursors.left.isDown)
      @body.rotateLeft(@turnRate)
    else if (@game.cursors.right.isDown)
      @body.rotateRight(@turnRate)
    else
      @body.setZeroRotation()

    if (@game.cursors.up.isDown)
      console.log('thrust', @maxThrust)
      @body.thrust(@maxThrust)
    else if (@game.cursors.down.isDown)
      @body.reverse(@maxThrust)

module.exports = Ship
