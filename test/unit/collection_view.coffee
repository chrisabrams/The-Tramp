$          = require 'jquery'
Backbone   = require 'backbone'
Backbone.$ = $
Chaplin    = require 'chaplin'
helper     = require '../lib/helper'

describe 'CollectionView - Unit', ->

  it 'should initialize', (done) ->

    CollectionView = require '../app/views/bare_coll'

    collectionView = new CollectionView
        collection: new Chaplin.Collection

    expect(collectionView).to.be.an 'object'
    expect(collectionView.attributesToString).to.be.a 'function'
    expect(collectionView.constructTag).to.be.a 'function'
    expect(collectionView.getAttributes).to.be.a 'function'
    expect(collectionView.getHtml).to.be.a 'function'
    expect(collectionView.getTemplateData).to.be.a 'function'
    expect(collectionView.ssRender).to.be.a 'boolean'
    expect(collectionView.ssRender).to.equal true

    done()

  it 'should get html from a view without a template', (done) ->

    CollectionView = require '../app/views/bare_coll'

    collectionView = new CollectionView
      collection: new Chaplin.Collection

    html = collectionView.getHtml()

    expect(html).to.be.a 'string'

    done()

  it 'should get html from a view with a template', (done) ->

    CollectionView = require '../app/views/bare_coll_wt'

    collectionView = new CollectionView
      collection: new Chaplin.Collection

    html = collectionView.getHtml()

    expect(html).to.be.a 'string'

    done()

  it 'should get html from a view with a template and list selector', (done) ->

    CollectionView = require '../app/views/bare_coll_wtls'

    collectionView = new CollectionView
      collection: new Chaplin.Collection [{name: 'Sam'}, {name: 'Kevin'}, {name: 'Derek'}, {name: 'Tamas'}, {name: 'Jeff'}]

    html = collectionView.getHtml()

    console.error "error 3 -> \n", html

    between = helper.getTextBetweenChars html, '<ul', '/ul'

    expect(html).to.be.a 'string'
    expect(between.indexOf('im-an-item-view')).to.be.above 0

    done()
