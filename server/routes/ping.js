var request = require('request');

module.exports = function(app) {
  app.get('/ping', function(req, res) {
    var url = req.query.url;

    if (!url) {
      return res.status(400).send('url must be defined');
    }

    request.head(url, function(error, response, body){
      if (error) {
        return res.status(200).send({
          statusCode: 404
        });
      }

      res.status(200).send({
        statusCode: response.statusCode
      });
    });
  });
};
