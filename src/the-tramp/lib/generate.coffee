_          = require 'underscore'
$          = require 'jquery'
Chaplin    = require 'chaplin'
fs         = require 'fs'
helper     = require './helpers/helper'
ViewHelper = require process.cwd() + '/src/the-tramp/lib/helpers/view'

module.exports = class HTMLGenerator
  _.extend @prototype, ViewHelper

  constructor: (options) ->

    @appPath = options.appPath
    @scripts = []

  appPath: null

  generate: (options) ->

    @handler    = options.handler or {}
    @req        = options.req or {}

    Controller  = require @appPath + "/controllers/#{@handler.route.controller}"
    @controller = new Controller

    return @generateHtml()

  generateHtml: ->

    @$body = @constructjQueryObject('<body></body>')

    @generateHtmlFromBeforeAction()
    @generateHtmlFromAction(new @controller[@handler.route.action](@req.params))

    body = helper.getTextBetweenChars @$body.html(), '<body>', '</body>'
    body = body.replace 'body>', ''

    console.error "body", body

    return body

  generateHtmlFromAction: (view) ->

    if view.ssRender

      viewHtml = @getHtmlFromViews view

      # View is bound to region
      if view.region

        @$body.find(Chaplin.mediator.regions[view.region]).append(viewHtml)

      # View is bound to container
      else if view.container

        @$body.find(view.container).append(viewHtml)

      # View did not assign itself to anything
      else
        console.error "e -> 3"

  generateHtmlFromBeforeAction: ->

    if @controller? and @controller.beforeAction?

      beforeAction = @controller.beforeAction()

      for index, view of Chaplin.mediator.compositions

        if view.regions

          viewHtml = view.getHtml()

          @$body.find(view.container).append(viewHtml)

        if view.region

          viewHtml = view.getHtml()

          container = Chaplin.mediator.regions[view.region]

          @$body.find(container)[view.containerMethod](viewHtml)

  getHtmlFromViews: (view) ->

    return view.getHtml()

  getScriptTagsFromBody: (body) ->

    re        = /<script\b[^>]*>([\s\S]*?)<\/script>/gm
    found     = undefined

    while found = re.exec(body)
      @scripts.push(found[0])
