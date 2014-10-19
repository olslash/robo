var Boot = new Phaser.State();

Boot.preload = function() {

};

Boot.create = function() {
  this.game.state.start('Preloader');
};

module.exports = Boot;
