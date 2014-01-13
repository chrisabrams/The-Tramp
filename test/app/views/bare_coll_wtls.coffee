CollectionView = require './base/collection-view'
ItemView       = require './bare_coll_item'

module.exports = class BareCollectionWTLSView extends CollectionView
  autoRender: true
  id: 'coll01'
  itemView: ItemView
  listSelector: 'ul'
  template: require '../templates/home'
