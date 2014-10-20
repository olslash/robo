class Module extends Phaser.Sprite
  constructor: (@game) ->
    super(@game, 0, 0, 'green32', 0)
    
    @energyRequired = 10

    @anchor.setTo(0.5, 0.5)
    @scale.setTo(1, 1)
    @game.physics.enable(this, Phaser.Physics.ARCADE)

  doAction: () ->

  moveTo: (x, y) ->
    [@x, @y] = [x, y]
  
  update: ->

module.exports = Module
