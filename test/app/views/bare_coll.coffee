CollectionView = require './base/collection-view'
ItemView       = require './bare_coll_item'

module.exports = class BareCollectionView extends CollectionView
  autoRender: true
  id: 'coll01'
  itemView: ItemView
