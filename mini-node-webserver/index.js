// main.js
const http = require("http");
const port = 4000;

const server = http.createServer((request, response) => {
    response.writeHead(200, {
      "Content-Type": "text/html"
    });

    const responseMessage = "hello from bore!";
    response.end(responseMessage);
});

server.listen(port);
console.log(`listening on port: ${port}`);
