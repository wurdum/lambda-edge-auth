const TerserPlugin = require('terser-webpack-plugin');

module.exports = {
  mode: 'production',
  target: 'node',
  node: {
    __dirname: false
  },
  entry: './src/index.ts',
  output: {
    filename: './index.js',
    libraryTarget: 'commonjs',
  },
  module: {
    rules: [
      {
        test: /\.ts$/,
        use: 'ts-loader',
        exclude: /node_modules/
      },
      {
        test: /\.html$/i,
        loader: 'html-loader',
        options: {
          minimize: true,
        },
      },
    ]
  },
  resolve: {
    extensions: [ '.ts', '.js' ]
  },
  externals: [
    /^aws-sdk/ // Don't include the aws-sdk in bundles as it is already present in the Lambda runtime
  ],
  performance: {
    hints: 'error',
    maxAssetSize: 1048576, // Max size of deployment bundle in Lambda@Edge Viewer Request
    maxEntrypointSize: 1048576, // Max size of deployment bundle in Lambda@Edge Viewer Request
  },
  optimization: {
    minimizer: [new TerserPlugin({
      cache: true,
      parallel: true,
      extractComments: true,
    })],
  },
}
