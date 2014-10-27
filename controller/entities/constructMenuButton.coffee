class ConstructMenuButton extends Phaser.Button
  constructor: (@game, {@asset, @callback}) ->
    super(@game, 0, 0, @asset, @callback)
