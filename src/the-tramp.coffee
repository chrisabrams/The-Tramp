module.exports =

  initialize: (options) ->

    @application = require __app + '/application'
    server       = options.server

    _             = require 'underscore'
    Backbone      = require 'backbone'
    $             = require 'jquery'

    Backbone.$    = $
    Chaplin       = require 'chaplin'
    hbs           = require 'hbs'
    
    Handlebars = hbs.handlebars

    routes = require __app + '/routes'
    routes Chaplin.Router.prototype.match

    # Find a matching route.
    for handler in Backbone.history.handlers

      ((handler) =>

        path = '/' + handler.route.pattern

        # Register Express route with Chaplin route pattern
        server.get path, (req, res) =>

          App = @application
    
          app = new App # Chaplin client-side app

          # Load template helpers
          templateHelpers = app.templateHelpers

          _.each templateHelpers, (helper) ->
            require(options.appPath + '/' + helper)(Handlebars)

          Generator = require(__dirname + '/the-tramp/lib/generate')

          generator = new Generator
            appPath: options.appPath
            handler: handler
            req:     req

          generated = generator.generate(req, handler)

          return res.render options.appPath + '/assets/index.hbs',
            body: generated.html

      ) handler
