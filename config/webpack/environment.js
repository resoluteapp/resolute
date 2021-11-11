const { environment } = require("@rails/webpacker");

environment.loaders.keys().forEach((loaderName) => {
  let loader = environment.loaders.get(loaderName);
  loader.use.forEach((loaderConfig) => {
    if (loaderConfig.options && loaderConfig.options.config) {
      loaderConfig.options.postcssOptions = loaderConfig.options.config;
      delete loaderConfig.options.config;
    }
  });
});

module.exports = environment;
