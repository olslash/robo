Controller = require './Controller'

RoboPhone = new Phaser.Game(480, 320, Phaser.AUTO, 'RoboPhone')

RoboPhone.state.add('Boot', require './states/bootState')
RoboPhone.state.add('Preloader', require './states/preloadState')
RoboPhone.state.add('Construct', require './states/constructState')

RoboPhone.state.start('Boot')

