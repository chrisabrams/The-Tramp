CollectionView = require './base/collection-view'
ItemView       = require './bare_coll_item'

module.exports = class BareCollectionWTView extends CollectionView
  autoRender: true
  id: 'coll01'
  itemView: ItemView
  template: require '../templates/home'
