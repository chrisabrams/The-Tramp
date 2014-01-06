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

    generator.generate
      handler: handler
      req:     req
