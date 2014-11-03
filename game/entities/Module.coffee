class Module extends Phaser.Sprite
  constructor: (@game, {@asset, @moduleName}) ->
    @asset or= 'green32'
    super(@game, 0, 0, @asset, 0)
    @ship = null # the ship we're installed on -- usually set by doSetup
    @control = null # an instance of a control type-- like a button or a slider, that will control this module

    @energyRequired = 10 # how much ship energy is required to fit this module

    # Phaser boilerplate
    @anchor.setTo(0.5, 0.5)
    @scale.setTo(1, 1)
    # @game.physics.p2.enable(this)

  doSetup: (@ship) ->
    # perform any actions on the ship-- like modify its movement properties

  doTeardown: (@ship) ->
    # reverse setup

  doAction: ->
    # do a special action -- like increase movement speed for 10 seconds


  moveTo: (x, y) ->
    # position the module on the ship's grid
    [@x, @y] = [x, y]

  orientTo: (direction) ->
    # N S W E
    @angle = switch direction.toLowerCase()
      when 'n' then 0
      when 's' then 180
      when 'w' then -90
      when 'e' then 90


  update: ->
    # any code that needs to be run every game tick

  serialize: ->
    moduleData = {}
    moduleData.name = @moduleName
    moduleData.orientation = @angle
    return moduleData

module.exports = Module
