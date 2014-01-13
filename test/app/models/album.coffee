Collection = require './base/collection'
Photo      = require './photo'

module.exports = class AlbumCollection extends Collection
  model: Photo
