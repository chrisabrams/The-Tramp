_                       = loader 'underscore'
Backbone                = loader 'backbone'
Chaplin                 = loader 'chaplin'
Collection              = loader 'models/base/collection'
Layout                  = loader 'views/layout/layout'
logger                  = loader 'lib/logger'
mediator                = loader 'mediator'
Router                  = Chaplin.Router
routes                  = loader 'routes'

module.exports = class DualApplication extends Chaplin.Application

  initialize: ->

    @initMediator()

    return if typeof window is 'undefined'

    # Check if app is already initialized.
    if @initialized
      throw new Error 'Application#initialize: App was already initialized'

    @initTemplateHelpers()
    @initTemplatePartials()

    @initRouter routes

    @initDispatcher()

    @initLayout()

    @initComposer()

    @initControllers()

    @startRouting()

    @initialized = true

  initComposer: (options) ->
    #@composer = new Composer options

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
      _.each @templateHelpers, (helper) ->
        loader(helper)(Handlebars)

  initTemplatePartials: ->
