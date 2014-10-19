var Preloader = new Phaser.State();

Preloader.preload = function() {
  this.game.load.image('blue32', 'game/assets/blue32.png');
  this.game.load.image('cyan32', 'game/assets/cyan32.png');
  this.game.load.image('green32', 'game/assets/green32.png');
  this.game.load.image('orange32', 'game/assets/orange32.png');
  this.game.load.image('red32', 'game/assets/red32.png');
};

Preloader.create = function() {
  this.game.state.start('Construct');
};

module.exports = Preloader;
