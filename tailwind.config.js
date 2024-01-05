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
  daisyui: {
    themes: [
      {
        mytheme: {
        "primary": "#15803d",
        "secondary": "#b45309",
        "accent": "#a21caf",
        "neutral": "#e7e5e4",
        "base-100": "#f3f4f6",
        "info": "#f3f4f6",
        "success": "#ffffff",
        "warning": "#ffffff",
        "error": "#be123c",
        },
      },
    ],
  },
  plugins: [require("daisyui")],
}
