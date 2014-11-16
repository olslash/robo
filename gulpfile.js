var gulp = require('gulp'),
  coffeeify = require('gulp-coffeeify'),
  stylus = require('gulp-stylus'),
  source = require('vinyl-source-stream'),
  jshint = require('gulp-jshint'),
  // uglify = require('gulp-uglify'),
  // concat = require('gulp-concat'),
  notify = require('gulp-notify'),
  del = require('del');

gulp.task('default', ['browserify', 'stylus']);

gulp.task('browserify', function() {
  // return browserify('./game/game.coffee')
  //   .bundle()
  //   .pipe(source('app.js'))
  //   .pipe(gulp.dest('./build/'))
  //   .pipe(notify({ message: 'Browserify task complete' }));

  gulp.src('./game/game.coffee')
        .pipe(coffeeify())
        .pipe(gulp.dest('./build'))
        .pipe(notify({ message: 'Game Browserify task complete' }));

  gulp.src('./controller/Controller.coffee')
      .pipe(coffeeify())
      .pipe(gulp.dest('./build'))
      .pipe(notify({message: 'Controller Browserify task complete'}));
});

gulp.task('stylus', function() {
    gulp.src('./controller/controller.styl')
        .pipe(stylus())
        .pipe(gulp.dest('./build'));
});

gulp.task('clean', function(cb) {
  del(['build/'], cb);
});

gulp.task('watch', function() {

  // Watch .styl files
  gulp.watch('**/*.styl', ['stylus']);

  // Watch .js files
  gulp.watch('**/*.coffee', ['browserify']);

  // Watch image files
  // gulp.watch('src/images/**/*', ['images']);
});