Chaplin = require 'chaplin'
SiteView = require '../../views/site-view'

module.exports = class Controller extends Chaplin.Controller

  beforeAction: ->
    @reuse 'site', SiteView

  initialize: ->

    if typeof window is 'undefined'

      @reuse = (name, View, region) ->

        if not Chaplin.mediator.compositions
          Chaplin.mediator.compositions = {}

        view = new View()

        if region
          view.region = region.region

        if not Chaplin.mediator.regions
          Chaplin.mediator.regions = {}

        # Regions are being defined
        if view.regions

          for index, selector of view.regions

            Chaplin.mediator.regions[index] = selector

        Chaplin.mediator.compositions[name] = view

    super
