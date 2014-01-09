BareView = require './bare'
View     = require './base/view'

module.exports = class BareWTView extends View
  autoRender: true
  className: 'shoutitman2'
  id: 'bareme2'
  template: require '../templates/home.js'

  initialize: ->
    super

    @subview('bare', new BareView)
