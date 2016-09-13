var gulp = require('gulp');

require('./compile-scss');
require('./copy-static-assets');
require('./watch');

gulp.task('default', ['initial-compile-and-copy']);

gulp.task('initial-compile-and-copy', [
  'copy-static-assets',
  'compile-scss',
  'watch'
]);

