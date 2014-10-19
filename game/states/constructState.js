var Ship = require('../entities/Ship');
var Module = require('../entities/Module');

var Construct = new Phaser.State();

Construct.preload = function() {
};

Construct.create = function() {
  this.doThingButton = this.add.button(100, 300, 'blue32', this.testModule, this);
  this.game.physics.startSystem(Phaser.Physics.P2);

  this.ship = new Ship(this.game, 100, 100);
  
  this.game.add.existing(this.ship);
};

Construct.testModule = function() {
  var aModule = new Module(this.game, 150, 150);
  this.ship.installModule(aModule, 0, 0);
};
  
module.exports = Construct;
