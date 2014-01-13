_ = require 'underscore'
$ = require 'jquery'

module.exports =

  ssRender: true

  # Convert attributes on a view element to a string
  attributesToString: ->

    attributes = @getAttributes()

    return _.inject(attributes, (memo, value, key) ->
      memo += " " + key + "=\"" + value + "\""
    , "")

  constructjQueryObject: (string) ->

    return $(@constructTag('div', null, string))

  # Create an HTML tag
  constructTag: (tag, attrs, string) ->

    attrs  = attrs or ''
    string = string or ''
    tag    = tag or 'div'

    return "<#{tag}#{attrs}>#{string}</#{tag}>"

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
  getHtml: (view, $html) ->

    if typeof view is 'object' and view isnt null
      view = view

    else
      view = @

    # We only want views that were intended to be rendered on the server-side
    if view.ssRender

      innerHtml  = view.getTemplateFunction()
      attributes = view.attributesToString()
      tagName    = view.tagname

      html       = @constructTag tagName, attributes, innerHtml

      # This is a child view, it's container should be available from the parent's html
      if $html

        container = null
        containerMethod = null
        
        if view.listSelector
          container = view.listSelector
          containerMethod = 'append'

        else if view.container
          container = view.container
          containerMethod = view.containerMethod

        if container
          $html.find(container)[containerMethod](html)

      # First time through this wont exist as its the top level view
      else

        unless $html
          $html = @constructjQueryObject html

      @loopThroughChildViews view, $html

      resultHtml = $html.html()

      return resultHtml

    else

      return ''

  loopThroughChildViews: (view, $html) ->

    # This is a collection view
    if @renderAllItems and @collection

      _.each @collection.models, (model, index) =>

        itemView = new @itemView
          model: model

        if @listSelector
          itemView.listSelector = @listSelector

        itemView.getHtml null, $html

    # This is a regular view
    else

      _.each view.subviews, (subview, index) ->

        view.getHtml subview, $html

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

  getTemplateFunction: ->
    
    if @template
      context = @getTemplateData()
      return @template context
