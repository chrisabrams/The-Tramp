_ = require 'underscore'
$ = require 'jquery'
Chaplin = require 'chaplin'

class HTMLGenerator

  constructor: (req, __app, handler) ->

    Controller = require __app + "/controllers/#{handler.route.controller}-controller"
    @controller = new Controller

    return @generateHtml(req, handler)

  attrToString: (view) ->

    attributes = view.getAttributes()

    return _.inject(attributes, (memo, value, key) ->
      memo += " " + key + "=\"" + value + "\""
    , "")

  generateHtml: (req, handler) ->

    @generateHtmlFromBeforeAction()
    @generateHtmlFromAction(new @controller[handler.route.action](req.params))

    generated =
      html: @htmlString

    generated

  generateHtmlFromAction: (action) ->

    for actionIndex, actionProp of action
      actionHtml  = ''
      $actionHtml = null

      if actionProp.ssRender
        actionHtml = @getHtmlFromViews actionProp

        # View is bound to region
        if actionProp.region
          $actionHtml = @generatejQueryHtmlString(@htmlString)
          $actionHtml.find(@regions[actionProp.region]).append(actionHtml)
          @htmlString = $actionHtml.html()

        # View is bound to container
        else if prop.container

          $actionHtml = @generatejQueryHtmlString(@htmlString)
          $actionHtml.find(actionProp.container)[actionProp.containerMethod](actionHtml)
          @htmlString = $actionHtml.html()

        # View did not assign itself to anything
        else

          @htmlString += @getHtmlFromViews actionProp

  generateHtmlFromBeforeAction: ->

    if @controller.beforeAction?

      beforeAction = @controller.beforeAction()

      # Go through any compositions that have been set in beforeAction() down the line
      for compIndex, compProp of Chaplin.mediator.compositions

        # This is an initial composition
        if compProp.view?.regions

          for regionIndex, region of compProp.view.regions
            @regions[regionIndex] = region

          compPropHtml = @getHtmlFromViews compProp.view
          @htmlString += compPropHtml

        # This is a partial composition to be applied to a previously set composition
        if compProp.region
          $compPropHtml = @generatejQueryHtmlString(@htmlString)
          compPropHtml = @getHtmlFromViews compProp.view
          $compPropHtml.find(@regions[compIndex]).append(compPropHtml)
          @htmlString = $compPropHtml.html()

  getHtmlFromViews: (view) ->

    viewHtml   = view.getHtml()
    attrString = @attrToString(view)
    html       = "<" + view.tagName + attrString + ">" + viewHtml + "</" + view.tagName + ">"
    $html      = $(html)

    if view.subviews.length > 0

      _.each view.subviews, (subview, index) ->

        # We only want sub-views that were intended to be rendered on the server-side
        if subview.ssRender

          subviewHtml = subview.getHtml()

          $html.find(subview.container)[subview.containerMethod](subviewHtml)

    return $html.html()

  generatejQueryHtmlString: (string) ->

    return $('<div>' + string + '</div>')

  htmlString: ''

  regions: {}

module.exports = (req, __app, handler) ->

  return new HTMLGenerator(req, __app, handler)
