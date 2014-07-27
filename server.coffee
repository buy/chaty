http          = require 'http'
fs            = require 'fs'
path          = require 'path'
mime          = require 'mime'

cache = {}

send404 = (res) ->
  res.writeHead 404, {'Content-Type': 'text/plain'}
  res.write 'Ooops, as you can see, this is a 404 error\n'
  res.end()

sendFile = (res, filePath, fileContents) ->
  res.writeHead 200, {'Content-Type': mime.lookup(path.basename(filePath))}
  res.end()

serveStatic = (res, cache, absPath) ->
  if cache.absPath
    sendFile res, absPath, cache.absPath
  else
    fs.exists absPath, (exists) ->
      if exists
        fs.readFile absPath, (err, data) ->
          if err
            send404 res
          else
            cache.absPath = data
            sendFile res, absPath, data
      else
        send404 res

server = http.createServer (req, res) ->
  if req.url == '/'
    filePath = 'public/index.html'
  else
    filePath = "public#{req.url}"

  absPath = "./#{filePath}"

  serveStatic res, cache, absPath

server.listen 3000, () ->
  console.log 'Server listing on port 3000 ...'
