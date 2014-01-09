BareView = require './bare'
View     = require './base/view'

module.exports = class BareWSVView extends View
  autoRender: true
  className: 'shoutitman'
  id: 'bareme'

  initialize: ->
    super

    @subview('bare', new BareView)
