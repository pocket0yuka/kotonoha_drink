module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {},
    fontFamily: {
      pops: ["Poppins","sans-serif"],
      maru: ["Zen Maru Gothic", "serif"],
    },
  },
  plugins: [require("daisyui")],
}
