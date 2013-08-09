module.exports  = class LayoutController extends Controller

  initialize: ->
    super

    @ # It is important to return @ at the end because we need @'s scope when on Node
