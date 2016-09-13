var gulp = require('gulp'),
    mergeStream = require('merge-stream'),
    gzip = require('gulp-gzip'),
    config = require('../config');

require('./rev');

gulp.task('gzip', ['rev'], function() {
  return mergeStream(
    gulp.src(config.distPath + '/javascripts/*.js')
      .pipe(gzip())
      .pipe(gulp.dest(config.distPath + '/javascripts')),
    gulp.src(config.distPath + '/stylesheets/*.css')
      .pipe(gzip())
      .pipe(gulp.dest(config.distPath + '/stylesheets'))
  );
});

