module.exports = {
  module: {
    rules: [
      {
        test: /\.js$/,
        loader: 'babel-loader',
        options: {
          plugins: [
            '@babel/plugin-proposal-optional-chaining',
          ],
        },
      },
    ],
  },
};