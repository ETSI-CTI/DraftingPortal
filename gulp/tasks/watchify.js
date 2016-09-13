var gulp = require('gulp'),
    compileJs = require('./compile-js');

gulp.task('watchify', function(callback) {
  // Start browserify task with devMode === true
  compileJs(callback, true);
});

