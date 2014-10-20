var Ship = require('../entities/Ship');
var Module = require('../entities/Module');

var Construct = new Phaser.State();

Construct.preload = function() {
};

Construct.create = function() {
  this.doThingButton = this.add.button(100, 300, 'blue32', this.testModule, this);
  this.doThing2Button = this.add.button(100, 350, 'orange32', this.test2Module, this);
  this.doThing3Button = this.add.button(100, 400, 'red32', this.test3Module, this);

  this.game.physics.startSystem(Phaser.Physics.ARCADE);

  this.ship = new Ship(this.game, 100, 100);
  
  this.game.add.existing(this.ship);
};

Construct.testModule = function() {
  var aModule = new Module(this.game);
  this.ship.installModule(aModule, 0, 0);
};

Construct.test2Module = function() {
  var aModule = new Module(this.game);
  this.ship.installModule(aModule, 1, 0);
};

Construct.test3Module = function() {
  var aModule = new Module(this.game);
  this.ship.installModule(aModule, 0, 2);
};
  
module.exports = Construct;
