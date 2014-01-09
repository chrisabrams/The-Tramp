$          = require 'jquery'
Backbone   = require 'backbone'
Backbone.$ = $
Generator  = require '../../src/the-tramp/lib/generate'

describe 'HTML Generator - Unit', ->

  it 'should be able to initialize', (done) ->

    generator = new Generator
      appPath: process.cwd() + '/test/app'

    expect(generator, 'generator').to.be.an 'object'
    expect(generator.attributesToString).to.be.a 'function'
    expect(generator.constructTag).to.be.a 'function'
    expect(generator.getAttributes).to.be.a 'function'
    expect(generator.getHtml).to.be.a 'function'
    expect(generator.getTemplateData).to.be.a 'function'

    done()

  it 'should be able to construct an HTML tag', (done) ->

    generator = new Generator
      appPath: process.cwd() + '/test/app'

    tag = generator.constructTag 'div', null, 'foobar'

    expect(tag).to.be.a 'string'
    expect(tag).to.equal '<div>foobar</div>'

    done()

  it 'should be able to convert attributes from a view into a string', (done) ->

    generator = new Generator
      appPath: process.cwd() + '/test/app'

    View = require '../app/views/bare'

    view = new View

    attributesAsString = generator.attributesToString view

    expect(attributesAsString).to.be.a 'string'

    done()

  it 'should be able to construct an HTML string inside a jQuery object', (done) ->

    generator = new Generator
      appPath: process.cwd() + '/test/app'

    html = generator.constructjQueryObject('hello').html()

    expect(html).to.be.a 'string'
    expect(html).to.equal 'hello'

    done()

  it 'should be able to get the html of a view', (done) ->

    generator = new Generator
      appPath: process.cwd() + '/test/app'

    View = require '../app/views/bare'

    view = new View

    html = generator.getHtmlFromViews(view)

    expect(html).to.be.a 'string'

    done()

  it 'should be able to get the html of a view with a subview', (done) ->

    generator = new Generator
      appPath: process.cwd() + '/test/app'

    View = require '../app/views/bare_wsv'

    view = new View

    html = generator.getHtmlFromViews(view)

    expect(html).to.be.a 'string'

    done()

  it 'should be able to get the html of a view that has a template and a subview', (done) ->

    generator = new Generator
      appPath: process.cwd() + '/test/app'

    View = require '../app/views/bare_wtsv'

    view = new View

    html = generator.getHtmlFromViews(view)

    expect(html).to.be.a 'string'

    done()
