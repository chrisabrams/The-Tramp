$          = require 'jquery'
Backbone   = require 'backbone'
Backbone.$ = $

Generator = require '../../src/the-tramp/lib/generate'

describe 'HTML Generator - Functional', ->

  it 'should be able to generate', (done) ->

    handler =
      route:
        action: 'index'
        controller: 'home'

    req =
      params: {}

    generator = new Generator
      appPath: process.cwd() + '/test/app'

    body = generator.generate
      handler: handler # backbone handler of route
      req:     req     # express request

    expect(body).to.be.a 'string'

    done()
