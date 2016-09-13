var gulp = require('gulp'),
    sass = require('gulp-sass'),
    bourbon = require('node-bourbon'),
    browserSync = require('browser-sync'),
    config = require('../config');

gulp.task('compile-scss', function() {
  return gulp.src(config.scssSrcPath + '/*.scss')
    .pipe(sass({
      outputStyle: 'compressed',
      includePaths: bourbon.with([
        config.scssSrcPath,
        config.bootstrapPath,
        config.fontawesomePath
      ]),
      errLogToConsole: true
    }).on('error', sass.logError))
    .pipe(gulp.dest(config.distPath + '/stylesheets'));
});

