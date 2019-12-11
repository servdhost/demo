var tailwindcss = require('tailwindcss');

module.exports = {
  plugins: [
    require('postcss-import'),
    tailwindcss('./tailwind.config.js'),
    require('postcss-nesting'),
    require('autoprefixer'),
    require('cssnano')
  ]
}
