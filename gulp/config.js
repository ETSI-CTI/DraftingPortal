var nodeModulesPath = './node_modules',
    assetPath = './assets',
    distPath = './public/assets',
    jsSrcPath = assetPath + '/javascripts';

module.exports = {
  bootstrapPath: nodeModulesPath + '/bootstrap-sass/assets/stylesheets',
  fontawesomePath: nodeModulesPath + '/font-awesome/scss',
  fontawesomeFiles: nodeModulesPath + '/font-awesome/fonts/*.*',
  assetPath: assetPath,
  viewPath: './app/views',
  distPath: distPath,
  jsSrcPath: jsSrcPath,
  scssSrcPath: assetPath + '/stylesheets',
  browserSync: {
    proxy: 'localhost:3000'
  },
  browserify: {
    bundleConfigs: [{
      paths: [jsSrcPath],
      entries: jsSrcPath + '/global.js',
      dest: distPath + '/javascripts',
      outputName: 'global.js',
      extensions: ['.js']
    }]
  }
};

