var gulp = require('gulp');

require('./copy-static-assets');
require('./rev');

gulp.task('dist', ['copy-static-assets', 'rev']);

