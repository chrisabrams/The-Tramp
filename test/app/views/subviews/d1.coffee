D2View   = require './d2'
View     = require '../base/view'

module.exports = class D1View extends View
  autoRender: true
  id: 'd1'
  template: require '../../templates/home.js'

  initialize: ->
    super

    @subview('d2', new D2View)
