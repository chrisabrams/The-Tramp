_          = require 'underscore'
Chaplin    = require 'chaplin'
ViewHelper = require process.cwd() + '/src/the-tramp/lib/helpers/view' # This obviously will change once this view is cleaned up for client-side

module.exports = class View extends Chaplin.View
  
  if typeof window is 'undefined'
    _.extend @prototype, ViewHelper

  preRendered: false

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

  render: ->

    # TODO - Ideally it would be nice to not render it the first time since that was done on Node
    #return false if @preRendered

    super
