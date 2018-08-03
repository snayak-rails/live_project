const { environment } = require('@rails/webpacker')


environment.loaders.get('sass').use
  .find(item => item.loader === 'sass-loader')
  .options.includePaths = ['node_modules', 'node_modules/datatables.net-dt'];

// resolve-url-loader must be used before sass-loader
environment.loaders.get('sass').use.splice(-1, 0, {
  loader: 'resolve-url-loader',
  options: {
    attempts: 1
  }
});

module.exports = environment
