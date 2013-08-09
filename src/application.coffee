_                       = loader 'underscore'
Chaplin                 = loader 'chaplin'
Collection              = loader 'models/base/collection'
Layout                  = loader 'views/layout/layout'
LayoutController        = loader 'controllers/layout_controller'
logger                  = loader 'lib/logger'
mediator                = loader 'mediator'
Router                  = Chaplin.Router
routes                  = loader 'routes'

module.exports = class DualApplication extends Chaplin.Application

  initialize: ->

    # We need some properties from this on Node, but we don't need it to start running.
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

    @initMediator()

    @initControllers()

    @startRouting()

    @initialized = true

  initComposer: ->
  initLayout: ->

  initControllers: ->
    new LayoutController

  initMediator: ->

  initRouter: (routes, options = {}) ->
    @router = new Router options

  initTemplateHelpers: ->

    if @templateHelpers

      _.each @templateHelpers, (helper) ->
        loader(helper)(Handlebars)

  initTemplatePartials: ->
