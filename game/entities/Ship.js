var _ = require('underscore');

var Ship = function(game, x, y, frame) {
  Phaser.Sprite.call(this, game, x, y, 'grid96', frame);
  // _.extend(this, require('../mixins/hasUniqueId'));

  this.modules =  [[  ],
                   [  ],
                   [  ]];

  this.energyRemaining = 100;

  this.anchor.setTo(0.5, 0.5);
  this.scale.setTo(1, 1);
  game.physics.enable(this, Phaser.Physics.ARCADE);
};

Ship.prototype = Object.create(Phaser.Sprite.prototype);
Ship.prototype.constructor = Ship;

Ship.prototype.installModule = function(module, x, y) {
  if(this.moduleSlotIsFree(x, y) && this.canSupportModule(module)) {
    this.modules[x][y] = module;
    
    var slotPixelCoordinates = this.getSlotPixelCoordinates(x, y);

    module.moveTo(slotPixelCoordinates[0], slotPixelCoordinates[1]);

    this.game.add.existing(module);
    this.addChild(module);
    return true;
  }

  return false;
};

Ship.prototype.moduleSlotIsFree = function(x, y) {
  if(this.modules[x][y] === undefined) { // todo: bounds checking
    return true;
  }
  return false;
};

Ship.prototype.canSupportModule = function() {
  // check energy or whatever
  return true;
};

Ship.prototype.getSlotPixelCoordinates = function(x, y) {
  // 0: -32
  // 1: 0
  // 2: 32

  var pixelX = -32;
  var pixelY = -32;

  return [pixelX + (x * 32), pixelY + (y * 32)];
};

Ship.prototype.updateControlState = function(state) {

};

Ship.prototype.update = function() {
  // update all modules
  this.modules.forEach(function(row) {
    row.forEach(function(module) {
      module.update();
    });
  });

  //testing code:
   if (this.game.input.mousePointer.isDown)
    {
        this.game.physics.arcade.moveToPointer(this, 400);
    }
    else
    {
        this.body.velocity.setTo(0, 0);
    }
};

module.exports = Ship;
