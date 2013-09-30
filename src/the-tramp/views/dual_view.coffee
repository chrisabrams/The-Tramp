_       = loader 'underscore'
Chaplin = loader 'chaplin'
View    = loader 'views/base/view'

if typeof window is 'undefined'

  fs = require 'fs'
  Handlebars = require('hbs').handlebars

else
  
  Handlebars = window.Handlebars

module.exports = class DualView extends View
  preRendered: false

  initialize: ->

    if typeof window is 'object'

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

    innerHtml = @getInnerHtml()

    attributes = @getAttributes()

    attrString = _.inject(attributes, (memo, value, key) ->
      memo += " " + key + "=\"" + value + "\""
    , "")

    html = "<" + @tagName + attrString + ">" + innerHtml + "</" + @tagName + ">"

    return html

  # Turn template into HTML, minus the wrapper element.

  getInnerHtml: ->

    html = @getTemplateFunction(@getTemplateData())

    return html

  # Precompiled templates function initializer.
  getTemplateFunction: (context) ->

    # Browser
    if typeof window is 'object'

      if @template

        return @_cachedTemplateFunction ||= require("templates/#{@template}")

      else

        return ''

    # Node
    else

      if @template

        # TODO - Figure out why @getTemplateData sometimes returns undefined
        if typeof context isnt 'object'
          
          if @model
            context = @model.toJSON()

          else
            context = {}

        source   = fs.readFileSync(process.cwd() + "/app/templates/#{@template}.hbs", "utf8")
        template = Handlebars.compile(source)
        result   = template(context)

        return result

      else
        return ''

  render: ->

    # TODO - Ideally it would be nice to not render it the first time since that was done on Node
    #return false if @preRendered

    super
