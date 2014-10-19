var game = new Phaser.Game(1024, 1024, Phaser.AUTO, 'game');

game.state.add('Boot', require('./states/bootState'));
game.state.add('Preloader', require('./states/preloadState'));
game.state.add('Construct', require('./states/constructState'));
// game.state.add('MainMenu', require('./states/mainMenuState'));
// game.state.add('ConnectControllers', require('./states/connectControllersState'));
// game.state.add('Play', require('./states/playState'));

game.state.start('Boot');