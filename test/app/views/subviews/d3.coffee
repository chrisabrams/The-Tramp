D4View   = require './d4'
D5View   = require './d5'
D6View   = require './d6'
View     = require '../base/view'

module.exports = class D3View extends View
  autoRender: true
  container: '#d2'
  id: 'd3'

  initialize: ->
    super

    @subview('d4', new D4View)
    @subview('d5', new D5View)
    @subview('d6', new D6View)
