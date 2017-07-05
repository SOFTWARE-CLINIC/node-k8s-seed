var HTTP_PORT = 8080;
var express = require('express');
var app = express();

app.get('/', function (request, response) {
  response.redirect('/hello');
});

app.get('/hello', function (request, response) {
  console.log('GET /hello');
  response.json({message: 'Hello, World!'});
});

app.get('/env', function (request, response) {
  response.json(process.env);
});

app.listen(HTTP_PORT, function () {
  console.log('Listening on port %d', HTTP_PORT);
});
