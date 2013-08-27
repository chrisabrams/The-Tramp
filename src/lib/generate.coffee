_ = require 'underscore'
$ = require 'jquery'

module.exports = (req, __app, handler) ->

  Controller = require __app + "/controllers/#{handler.route.controller}_controller"
  DualView = require __app + '/views/base/dual_view'
  Layout = require __app + "/views/layout/layout"

  html = ''

  layout = new Layout

  layoutViews = {}

  for index, prop of layout
    
    if prop instanceof DualView
      layoutViews[index] = prop.getHtml()

  controller = new Controller

  if controller.beforeAction?
    controller.beforeAction()

  action = new controller[handler.route.action](req.params)

  getHtmlFromViews = (view) ->

    viewHtml = view.getHtml()

    attrString = require(__dirname + '/attrs_to_string')(view)

    html = "<" + view.tagName + attrString + ">" + viewHtml + "</" + view.tagName + ">"

    $html = $(html)

    if view.subviews.length > 0

      _.each view.subviews, (subview, index) ->

        # We only want sub-views that were intended to be rendered on the server-side
        if subview instanceof DualView

          subviewHtml = subview.getHtml()

          $html.find(subview.container)[subview.containerMethod](subviewHtml)

    return $html.html()

  for index, prop of action
    
    if prop instanceof DualView
      html += getHtmlFromViews prop

  return {
    html: html
    layoutViews: layoutViews
  }