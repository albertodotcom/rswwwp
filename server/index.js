// To use it create some files under `routes/`
// e.g. `server/routes/ember-hamsters.js`
//
// module.exports = function(app) {
//   app.get('/ember-hamsters', function(req, res) {
//     res.send('hello');
//   });
// };

module.exports = function(app) {
  var globSync   = require('glob').sync;
  var routes      = globSync('./routes/**/*.js', { cwd: __dirname }).map(require);

  // Log proxy requests
  var morgan  = require('morgan');
  app.use(morgan('dev'));

  routes.forEach(function(route) { route(app); });
};
