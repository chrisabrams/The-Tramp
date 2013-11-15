module.exports =

  initialize: (options) ->

    __app = options.appPath
    @application = require __app + '/application'
    server = options.server

    _             = require 'underscore'
    Backbone      = require 'backbone'
    $             = require 'jquery'

    Backbone.$    = $
    Chaplin       = require 'chaplin'
    hbs           = require 'hbs'
    
    Handlebars = hbs.handlebars

    routes = require __app + '/routes'
    routes(Chaplin.Router.prototype.match)

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
            require(__app + '/' + helper)(Handlebars)

          generated = require(__dirname + '/the-tramp/lib/generate')(req, __app, handler)

          return res.render __app + '/assets/index.hbs',
            body: generated.html

      ) handler
