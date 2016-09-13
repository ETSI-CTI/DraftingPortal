var gulp = require('gulp'),
    config = require('../config');

gulp.task('copy-static-assets', [
  'compress-images',
  'copy-fontawesome-fonts'
], function() {
  return gulp.src(config.assetPath + '/fonts/**/*')
    .pipe(gulp.dest(config.distPath + '/fonts'));
});

gulp.task('copy-fontawesome-fonts', function() {
  return gulp.src(config.fontawesomeFiles)
    .pipe(gulp.dest(config.distPath + '/fonts'));
});

