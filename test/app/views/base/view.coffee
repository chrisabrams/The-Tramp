_          = require 'underscore'
Chaplin    = require 'chaplin'
Handlebars = require 'hbsfy/runtime'

module.exports = class View extends Chaplin.View
  preRendered: false
  ssRender: true

  initialize: ->

    if typeof window is 'object'

      # This logic is pretty shitty
      if @id

        el = "##{@id}"

        if $(el).length > 0
          @el = el
          @$el = $(@el)
          @preRendered = true

      else if @className

        el = "##{@className}"

        if $(el).length > 0
          @el = el
          @$el = $(@el)
          @preRendered = true

    else

      @attach = ->
      @delegate = ->
      @delegateEvents = ->
      @delegateListeners = ->

    super

  attach: ->

    if @preRendered

      @trigger 'addedToDOM'

      return false

    super

  # Get HTML attributes to add to el.
  getAttributes: ->
    attributes = {}
    attributes.id = @id if @id
    attributes["class"] = @className if @className
    
    # Add model & collection meta data from options,
    # as well as any non-object option values.
    _.each @options, (value, key) ->

      if value?

        attributes["data-" + key] = _.escape(value) if not _.isObject(value) and not _.include(@nonAttributeOptions, key)

    return attributes

  # Get the HTML for the view, including the wrapper element.
  getHtml: ->

    innerHtml  = @getTemplateFunction()
    attributes = @getAttributes()

    attrString = _.inject(attributes, (memo, value, key) ->
      memo += " " + key + "=\"" + value + "\""
    , "")

    html = "<" + @tagName + attrString + ">" + innerHtml + "</" + @tagName + ">"

    return html

  getTemplateData: ->
    utils = require('chaplin').utils

    data = null

    if @model
      data = @model.toJSON()

    else if @collection
      data = @collection.toJSON()

    else
      data = {}

    return data

  # Precompiled templates
  getTemplateFunction: ->
    
    if @template
      context = @getTemplateData()
      return @template context

  render: ->

    # TODO - Ideally it would be nice to not render it the first time since that was done on Node
    #return false if @preRendered

    super
