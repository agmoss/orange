var serveStatic = require("serve-static");
var finalHandler = require("finalhandler");
var http = require("http");

const serve = serveStatic(__dirname + "/build");

const server = http.createServer(
  (onRequest = (req, res) => {
    serve(req, res, finalHandler(req, res));
  })
);

server.listen(8080, () => {
  console.log("server running on 8080...");
});
