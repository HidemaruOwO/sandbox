// main.js
const http = require("http");
const port = process.argv[2];

if (port == void 0) {
   console.log("Portを第三引数に入力してください");
} else {
   const server = http.createServer((request, response) => {
      response.writeHead(200, {
         "Content-Type": "text/html"
      });

      const responseMessage = "listening on " + port + " port.";
      response.end(responseMessage);
   });
   server.listen(port);
   console.log(`listening on port: ${port}`);
}
