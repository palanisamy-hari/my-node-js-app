var express = require('express');
var app = express();

app.get('/', function (req, res) {
  res.send('Hello World! - Deployed');
});
module.exports = app;