var gulp = require('gulp'),
    browserSync = require('browser-sync'),
    config = require('../config');

require ('./browser-sync');
require ('./compile-scss');
require ('./watchify');

gulp.task('watch', ['watchify', 'browser-sync'], function() {
  // Watchify will take care of JS, so no need to watch it here
  gulp.watch([config.scssSrcPath + '/**/*.scss'], ['compile-scss']);
  gulp.watch([config.viewPath + '/**/*.{slim, erb}'], browserSync.reload);
  // Reload the page after asset was recompiled
  gulp.watch([config.distPath + '/**/*'], browserSync.reload);
});
