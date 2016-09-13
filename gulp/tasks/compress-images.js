var gulp = require('gulp'),
    imagemin = require('gulp-imagemin'),
    pngquant = require('imagemin-pngquant'),
    config = require('../config');

gulp.task('compress-images', function() {
  return gulp.src(config.assetPath + '/images/**/*')
    .pipe(imagemin({
      progressive: true,
      use: [pngquant]
    }))
    .pipe(gulp.dest(config.distPath + '/images'));
});

