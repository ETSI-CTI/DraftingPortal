var gulp = require('gulp'),
    del = require('del'),
    rev = require('gulp-rev'),
    uglify = require('gulp-uglify'),
    compileJs = require('./compile-js'),
    config = require('../config');

require('./compile-scss');
require('./compile-js');

gulp.task('rev', ['clean-dist', 'compile-scss', 'minified-js'], function() {
  return gulp.src([
      config.distPath + '/stylesheets/*.css',
      config.distPath + '/javascripts/*.js'
    ],
    { base: config.distPath }
  )
  //.pipe(rev())  -> rake assets:precompile will actually handle this
  //.pipe(gulp.dest(config.distPath))
  //.pipe(rev.manifest())
  .pipe(gulp.dest(config.distPath));
});

gulp.task('clean-dist', function() {
  del.sync([config.distPath + '/**/*']);
});

gulp.task('minified-js', ['compile-production-js'], function() {
  return gulp.src(config.distPath + '/javascripts/*.js')
    .pipe(uglify())
    .pipe(gulp.dest(config.distPath + '/javascripts'));
});

gulp.task('compile-production-js', ['lint'], function(callback) {
  compileJs(callback, false);
});

