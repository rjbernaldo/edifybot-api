var webpack = require('webpack');

module.exports = {
  entry: [
    './src/index'
  ],
  module: {
    loaders: [{
      test: /\.jsx?$/,
      exclude: /node_modules/,
      loader: 'babel'
    }, {
      test: /\.css$/,
      loader: 'style!css'
    }]
  },
  resolve: {
    extensions: ['', '.js', '.jsx']
  },
  output: {
    path: __dirname + '/../public/app',
    publicPath: '/app/',
    filename: 'bundle.js'
  },
  devServer: {
    contentBase: '../public/app',
    hot: true
  },
  plugins: [
    new webpack.HotModuleReplacementPlugin()
  ]
}
