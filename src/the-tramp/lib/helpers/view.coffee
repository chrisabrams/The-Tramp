_ = require 'underscore'
$ = require 'jquery'

module.exports =

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

    view = view or @

    # We only want views that were intended to be rendered on the server-side
    if view.ssRender

      innerHtml  = view.getTemplateFunction()
      attributes = view.attributesToString()
      tagName    = view.tagname

      html       = @constructTag tagName, attributes, innerHtml

      # This is a child view, it's container should be available from the parent's html
      if $html

        if view.container

          $html.find(view.container)[view.containerMethod](html)

        @loopThroughSubViews view, $html

      # First time through this wont exist as its the top level view
      else

        unless $html
          $html = @constructjQueryObject html

        @loopThroughSubViews view, $html

        resultHtml = $html.html()

        $html = null

        return resultHtml

    else

      return ''

  loopThroughSubViews: (view, $html) ->

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
