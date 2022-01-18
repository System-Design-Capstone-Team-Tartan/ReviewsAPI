const reviews = require('./reviews');

const meta = require('./meta');

module.exports = (app) => {
  app.use('/reviews', reviews);
  app.use('/meta', meta);
};
