$             = require 'jquery'
_             = require 'underscore'
Chaplin       = require 'chaplin'

module.exports = (__app, Handlebars, server) ->

  # This is the loader Chaplin uses, abstracted into it separate Node module
  global.loader = require('loader')(__app)

  App      = require __app + '/application'
  DualView = require __app + '/views/base/dual_view'
  
  app = new App # Chaplin client-side app

  # Load template helpers
  templateHelpers = app.templateHelpers

  _.each templateHelpers, (helper) ->
    require(__app + '/' + helper)(Handlebars)

  server.get '*', (req, res) ->
    #console.log "route * called: ", req.route.params[0]

    handlers = []

    match = (pattern, target, options) ->
      #console.log "args", arguments

      if arguments.length is 2 and typeof target is 'object'

        # Handles cases like `match 'url', controller: 'c', action: 'a'`.
        options = target
        {controller, action} = options
        
        unless controller and action
          throw new Error 'Router#match must receive either target or ' +
            'options.controller & options.action'

      else

        # Handles `match 'url', 'c#a'`.
        if typeof options is 'object'
          {controller, action} = options

          if controller or action
            throw new Error 'Router#match cannot use both target and ' +
              'options.controller / options.action'

        # Separate target into controller and controller action.
        [controller, action] = target.split('#')

      # Create the route.
      route = new Chaplin.Route pattern, controller, action, options

      handlers.push({route: route})

    routes = require __app + '/routes'
    routes(match)

    if req.route.params[0].charAt(0) is '/'
      uri = req.route.params[0].substring(1)

    # Find a matching route.
    for handler in handlers

      if handler.route.test(uri)

        html = ''

        Controller = require __app + "/controllers/#{handler.route.controller}_controller"
        LayoutController = require __app + "/controllers/layout_controller"

        layoutController = new LayoutController

        setupViews = {}

        for index, prop of layoutController
          
          if prop instanceof DualView
            
            setupViews[index] = prop.getHtml()

        controller = new Controller

        if controller.beforeAction?
          controller.beforeAction()

        action = new controller[handler.route.action]()

        getHtmlFromViews = (view) ->

          html  = view.getHtml()
          $html = $(html)

          if view.subviews.length > 0

            _.each view.subviews, (subview, index) ->
              #console.log "subview list[] ", index

              # We only want sub-views that were intended to be rendered on the server-side
              if subview instanceof DualView

                subviewHtml = subview.getHtml()

                $html.find(subview.container)[subview.containerMethod](subviewHtml)

          attributes = view.getAttributes()

          attrString = _.inject(attributes, (memo, value, key) ->
            memo += " " + key + "=\"" + value + "\""
          , "")

          return "<" + view.tagName + attrString + ">" + $html.html() + "</" + view.tagName + ">"

        for index, prop of action
          
          if prop instanceof DualView
            html += getHtmlFromViews prop

        return res.render __app + '/assets/index.hbs',
          body: html
          #locals: {handler: handler}
          views: setupViews
