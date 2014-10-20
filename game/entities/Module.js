var _ = require('underscore');

var Module = function(game, frame) {
  // a module has a sprite, possibly some controllable behavior

  Phaser.Sprite.call(this, game, 0, 0, 'green32', frame);
  // _.extend(this, require('../mixins/hasUniqueId'));
  this.energyRequired = 10;
  
  this.anchor.setTo(0.5, 0.5);
  this.scale.setTo(1, 1);
  game.physics.enable(this, Phaser.Physics.ARCADE);
};

Module.prototype = Object.create(Phaser.Sprite.prototype);
Module.prototype.constructor = Module;

Module.prototype.doAction = function() {
  // fire gun, turbo boost, etc
};

Module.prototype.moveTo = function(x, y) {
  this.x = x;
  this.y = y;
};

Module.prototype.update = function() {

};


module.exports = Module;
