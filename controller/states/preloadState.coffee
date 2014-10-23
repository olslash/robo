Preloader = new Phaser.State()

Preloader.preload = ->
  @game.load.image('blue32', '../game/assets/blue32.png');
  @game.load.image('cyan32', '../game/assets/cyan32.png');
  @game.load.image('green32', '../game/assets/green32.png');
  @game.load.image('orange32', '../game/assets/orange32.png');
  @game.load.image('red32', '../game/assets/red32.png');
  @game.load.image('grid96', '../game/assets/grid96.png');

Preloader.create = ->
  @game.state.start 'Construct'

module.exports = Preloader
