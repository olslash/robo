var gulp = require('gulp'),
  coffeeify = require('gulp-coffeeify'),
  source = require('vinyl-source-stream'),
  jshint = require('gulp-jshint'),
  // uglify = require('gulp-uglify'),
  // concat = require('gulp-concat'),
  notify = require('gulp-notify'),
  del = require('del');

gulp.task('default', ['browserify']);

// gulp.task('scripts', function() {
//   return gulp.src(['game/**/*.js', 'game/*.js'])
//     // .pipe(jshint('.jshintrc'))
//     // .pipe(jshint.reporter('default'))
//     .pipe(concat('app.js'))
//     .pipe(gulp.dest('build'))
//     // .pipe(rename({suffix: '.min'}))
//     // .pipe(uglify())
//     // .pipe(gulp.dest('dist/assets/js'))
//     .pipe(notify({ message: 'Scripts task complete' }));
// });

gulp.task('browserify', function() {
  // return browserify('./game/game.coffee')
  //   .bundle()
  //   .pipe(source('app.js'))
  //   .pipe(gulp.dest('./build/'))
  //   .pipe(notify({ message: 'Browserify task complete' }));

  return gulp.src('./game/game.coffee')
        .pipe(coffeeify())
        .pipe(gulp.dest('./build'))
        .pipe(notify({ message: 'Browserify task complete' }));
});

gulp.task('clean', function(cb) {
  del(['build/'], cb);
});

gulp.task('watch', function() {

  // Watch .scss files
  // gulp.watch('src/styles/**/*.scss', ['styles']);

  // Watch .js files
  gulp.watch('game/**/*.coffee', ['browserify']);

  // Watch image files
  // gulp.watch('src/images/**/*', ['images']);
});