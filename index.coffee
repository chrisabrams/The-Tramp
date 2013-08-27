module.exports = (__app, Handlebars, server, paths) ->

  global.loader = require('./lib/loader')(__app, paths)

  _             = require process.cwd() + '/node_modules/underscore'
  Backbone      = loader 'backbone'
  $             = require process.cwd() + '/node_modules/jquery'
  #$ = require 'cheerio' - Doesn't work
  Backbone.$    = $
  Chaplin       = loader 'chaplin'

  handlers = []

  match = require(__dirname + '/lib/match')(handlers)

  routes = require __app + '/routes'
  routes(match)

  # Find a matching route.
  for handler in handlers

    ((handler) ->

      path = '/' + handler.route.pattern

      # Register Express route with Chaplin route pattern
      server.get path, (req, res) ->

        App = require __app + '/application'
  
        app = new App # Chaplin client-side app

        # Load template helpers
        templateHelpers = app.templateHelpers

        _.each templateHelpers, (helper) ->
          require(__app + '/' + helper)(Handlebars)

        generated = require(__dirname + '/lib/generate')(req, __app, handler)

        return res.render __app + '/assets/index.hbs',
          body: generated.html
          layoutViews: generated.layoutViews

    ) handler
