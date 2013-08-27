$ = require 'jquery'
_ = require 'underscore'

module.exports = class Generator

  constructor: (__app, handler) ->
    @__app   = __app
    @handler = handler

    @DualView = require @__app + '/views/base/dual_view'

  attributesToString: (view) ->
    attributes = @getViewAttributes(view)

    return _.inject(attributes, (memo, value, key) ->
      memo += " " + key + "=\"" + value + "\""
    , "")

  constructView: ->

    $html = $(html)

    $html = @getHtmlFromSubViews(view, $html)
    
    return @createViewTag(view, $html)

  createViewTag: (view, $html) ->
    attrString = @attributesToString(view)

    return "<" + view.tagName + attrString + ">" + $html.html() + "</" + view.tagName + ">"

  generateContext: ->

    Controller = @getController(handler)
    controller = new Controller

    if controller.beforeAction?
      controller.beforeAction()

    action = @getAction(controller)

  getAction: (controller) ->
    return new controller[@handler.route.action]()

  getController: ->
    return require @__app + "/controllers/#{@handler.route.controller}_controller"

  getHtmlFromView: (view) ->
    return view.getHtml()

  getHtmlFromSubView: (subview, $html) ->

    # We only want a sub-view that were intended to be rendered on the server-side
    if subview instanceof @DualView

      html = @getHtmlFromView(subview)

      $html.find(subview.container)[subview.containerMethod](html)

    return $html

  getHtmlFromSubViews: (view, $html) ->

    subviews = @getSubViews(view)

    _.each subviews, (subview, index) =>

      # Get html from sub-view
      $html = @getHtmlFromSubView(subview, $html)

      # Get html from sub-views of a sub-view
      $html = @getHtmlFromSubViews(subview, $html)

    return $html

  getHtmlFromAction = (action) ->
    
    # Get layout html
    html  = ''
    views = @getLayoutHtml()

    for index, prop of action
    
      if prop instanceof @DualView
        html += getHtmlFromViews prop

    generated =
      html: html
      views: views

    return generated

  getLayoutHtml: ->

    LayoutController = require @__app + "/controllers/layout_controller"
    layoutController = new LayoutController
    views = {}

    for index, prop of layoutController
      
      if prop instanceof @DualView
        
        views[index] = prop.getHtml()

    return views

  getSubViews: (view) ->
    return view.subviews

  getViewAttributes: (view) ->
    return view.getAttributes()
