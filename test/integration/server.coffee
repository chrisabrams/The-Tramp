# - Dependencies
$          = require 'jquery'
Backbone   = require 'backbone'
Backbone.$ = $

Chaplin       = require 'chaplin'
hbs           = require 'hbs'
util          = require 'util'

express       = require 'express'
server        = express()

port          = 4040

Generator     = require '../../src/the-tramp/lib/generate'

# - Server Settings
#server.set 'views', path.join(__dirname)
server.set 'view engine', 'hbs'
server.set 'view options', { layout: false }
server.engine 'hbs', hbs.__express

server.use express.static __dirname + '/public'
server.use express.favicon()
server.use express.logger 'dev'
server.use express.query()
server.use express.bodyParser()
server.use express.cookieParser 'fosho'
server.use express.methodOverride()

server.use express.errorHandler()
server.use server.router

server.get '*', (req, res) ->

  handler =
    route:
      action: 'index'
      controller: 'home'

  req =
    params: {}

  generator = new Generator
    appPath: process.cwd() + '/test/app'

  body = generator.generate
    handler: handler # backbone handler of route
    req:     req     # express request

  return res.render __dirname + '/../app/assets/index.hbs',
    body: body

# - Start Up Server
server.listen port
util.log "Express server instance listening on port " + port
