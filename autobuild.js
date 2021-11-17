var http = require('http');
var fs = require('fs');
const {exec} = require('child_process');
const ws = require('ws');
var watch = require('node-watch');
var pageContent = "";
// read file "hotinject.js" synchronously
var hotinject = fs.readFileSync("hotinject.js", "utf8");

// serve variable
http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/html', 'Content-Security-Policy' : 'connect-src ws://localhost:8081'});
  res.end(pageContent);
}).listen(8080);

function injectSrc(html){
  // replace '<html>' with '<html><script src="hotinject.js"></script>'
  return html.replace("<html >", "<html><script>"+hotinject+"</script>");
}

const file_name = "blog.hs"

//reload function
function reload() {
  exec(`runghc ${file_name}`, (error, stdout, stderr) => {
    if (error) {
      console.error(`exec error: ${error}`);
      return;
    }
    pageContent = injectSrc(stdout);
    setTimeout(function(){
      wss.broadcast("reload");
    }, 10);
  });
}

reload();
watch('.', { recursive: true }, function(evt, name) {
  if (name == file_name){
    reload();
  }
});

const wss = new ws.Server({ port: 8081 });

wss.broadcast = function broadcast(msg) {
  console.log(msg);
  wss.clients.forEach(function each(client) {
      client.send(msg);
   });
};