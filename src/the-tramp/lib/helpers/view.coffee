_ = require 'underscore'
$ = require 'jquery'

module.exports =

  # Convert attributes on a view element to a string
  attributesToString: (view) ->

    view = view or @ # Let this be used directly on a view or pass in a view

    attributes = view.getAttributes()

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
  getHtml: ->

    innerHtml  = @getTemplateFunction()
    attributes = @attributesToString()

    return @constructTag @tagName, attributes, innerHtml

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
