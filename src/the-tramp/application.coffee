_                       = require 'underscore'
Chaplin                 = require 'chaplin'
Layout                  = require 'views/layout/layout'
Router                  = Chaplin.Router
routes                  = require 'routes'

module.exports = class DualApplication extends Chaplin.Application

  initialize: (options) ->

    @initMediator()

    return if typeof window is 'undefined'

    # Check if app is already initialized.
    if @initialized
      throw new Error 'Application#initialize: App was already initialized'

    @initTemplateHelpers()
    @initTemplatePartials()
    @initRouter options.routes, options
    @initDispatcher options
    @initLayout options
    @initComposer options
    @initControllers()
    @start()

    @initialized = true

  # Override standard layout initializer
  # ------------------------------------
  initLayout: ->
    # Use an application-specific Layout class. Currently this adds
    # no features to the standard Chaplin Layout, it’s an empty placeholder.
    @layout = new Layout {@title}

  # Instantiate common controllers
  # ------------------------------
  initControllers: ->

  # Create additional mediator properties
  # -------------------------------------
  initMediator: ->
    #mediator.seal()

  initTemplateHelpers: ->

    if @templateHelpers
      Handlebars = require 'handlebars'

      _.each @templateHelpers, (helper) ->
        require(helper)(Handlebars)

  initTemplatePartials: ->
