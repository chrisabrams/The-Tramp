D7View   = require './d7'
D8View   = require './d8'
D9View   = require './d9'
View     = require '../base/view'

module.exports = class D5View extends View
  autoRender: true
  container: '#d3'
  id: 'd5'

  initialize: ->
    super

    @subview('d7', new D7View)
    @subview('d8', new D8View)
    @subview('d9', new D9View)
