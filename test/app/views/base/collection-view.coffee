_          = require 'underscore'
Chaplin    = require 'chaplin'
View       = require './view'
ViewHelper = require process.cwd() + '/src/the-tramp/lib/helpers/view' # This obviously will change once this view is cleaned up for client-side

module.exports = class CollectionView extends Chaplin.CollectionView

  if typeof window is 'undefined'
    _.extend @prototype, ViewHelper

  animationDuration: 0
  useCssAnimation: yes

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
      @addCollectionListeners = ->
      @delegate = ->
      @delegateEvents = ->
      @delegateListeners = ->

    super

  attach: ->

    if @preRendered

      @trigger 'addedToDOM'

      return false

    super
