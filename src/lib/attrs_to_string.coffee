_ = require 'underscore'

module.exports = (view) ->

  attributes = view.getAttributes()

  return _.inject(attributes, (memo, value, key) ->
    memo += " " + key + "=\"" + value + "\""
  , "")
