D3View   = require './d3'
View     = require '../base/view'

module.exports = class D2View extends View
  autoRender: true
  container: '#d1'
  id: 'd2'

  initialize: ->
    super

    @subview('d3', new D3View)
