module.exports = {
  plugins: [
    require("postcss-import"),
    require("postcss-url")({
      url: "copy",
      useHash: true,
    }),
    require("tailwindcss"),
    require("autoprefixer"),
    ...(process.env.NODE_ENV === "production" ? [require("cssnano")] : []),
  ],
};
