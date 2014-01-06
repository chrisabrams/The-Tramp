Generator = require '../../src/the-tramp/lib/generate'

describe 'HTML Generator - Unit', ->

  it 'should be able to initialize', (done) ->

    generator = new Generator
      appPath: process.cwd() + '/test/app'

    expect(generator, 'generator').to.be.an 'object'

    done()

  it 'should be able to generate attributes from a view into a string', (done) ->

    View = require '../app/views/home/home-page-view'

    view = new View

    attributesAsString = attrToString view

    expect(attributesAsString).to.be.a 'string'

    done()

  it 'should be able to generate an HTML string inside a jQuery object', (done) ->

    generator = new Generator
      appPath: process.cwd() + '/test/app'

    html = generator.generatejQueryHtmlString('hello').html()

    expect(html).to.be.a 'string'
    expect(html).to.equal 'hello'

    done()
