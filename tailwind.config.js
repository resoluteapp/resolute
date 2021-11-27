module.exports = {
  purge: ["./app/views/**/*.html.{haml,erb}", "./app/helpers/**/*.rb"],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      fontFamily: {
        heading: ["Outfit", "sans-serif"],
      },
    },
  },
  variants: {
    extend: {
      transform: ["hover", "group-hover"],
    },
  },
  plugins: [],
};
