###
getAttributes() and getHtml() inspired from Rendr.
###

_       = loader 'underscore'
View    = loader 'views/base/view'

# Node
if typeof window is 'undefined'

  fs = require 'fs'
  Handlebars = require('hbs').handlebars

# Browser
else
  
  Handlebars = window.Handlebars

module.exports = class DualView extends View
  preRendered: false # Rendered on server-side?

  initialize: ->

    if typeof window is 'object'

      if @id and $(@id).length > 0
        @el = "##{@id}"
        @$el = $(@el)
        @preRendered = true

      else if @className and $(@className).length > 0
        @el = "##{@className}"
        @$el = $(@el)
        @preRendered = true

    else

      # Don't want these to fire on server-side
      @attach = ->
      @delegate = ->
      @delegateEvents = ->
      @delegateListeners = ->

    super

  attach: ->
    return false if @preRendered

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

        if key is "model"

          key = "model_id"
          id = value[value.idAttribute]
          
          # Bail if there's no ID; someone's using `this.model` in a
          # non-standard way, and that's okay.
          return unless id?
          
          # Cast the `id` attribute to string to ensure it's included in attributes.
          # On the server, it can be i.e. an `ObjectId` from Mongoose.
          value = id.toString()

        else if key is "collection"

          key = "collection_params"
          value = _.escape(JSON.stringify(value.params))

        attributes["data-" + key] = _.escape(value) if not _.isObject(value) and not _.include(@nonAttributeOptions, key)

    attributes

  # Get the HTML for the view, including the wrapper element.
  getHtml: ->

    html = @getInnerHtml()

    attributes = @getAttributes()

    attrString = _.inject(attributes, (memo, value, key) ->
      memo += " " + key + "=\"" + value + "\""
    , "")

    return "<" + @tagName + attrString + ">" + html + "</" + @tagName + ">"

  # Turn template into HTML, minus the wrapper element.
  getInnerHtml: ->

    html = @getTemplateFunction(@getTemplateData())

    return html

  # Precompiled templates function initializer.
  getTemplateFunction: (context) ->

    # Browser
    if typeof window is 'object'
      return @_cachedTemplateFunction ||= require("templates/#{@template}")

    # Node
    else
      source = fs.readFileSync(process.cwd() + "/app/templates/#{@template}.hbs", "utf8")
      template = Handlebars.compile(source)

      return template(context)

  render: ->

    # TODO - Ideally it would be nice to not render it the first time since that was done on Node
    #return false if @preRendered

    super
