$          = require 'jquery'
Backbone   = require 'backbone'
Backbone.$ = $

describe 'View - Unit', ->

  it 'should be able to initialize', (done) ->

    View = require '../app/views/bare'

    view = new View

    expect(view).to.be.an 'object'
    expect(view.attributesToString).to.be.a 'function'
    expect(view.constructTag).to.be.a 'function'
    expect(view.getAttributes).to.be.a 'function'
    expect(view.getHtml).to.be.a 'function'
    expect(view.getTemplateData).to.be.a 'function'
    expect(view.ssRender).to.be.a 'boolean'
    expect(view.ssRender).to.equal true

    done()

  it 'should be able to get template data', (done) ->

    Home = require '../app/models/home'
    View = require '../app/views/bare'

    view = new View
      model: new Home

    data = view.getTemplateData()

    expect(data).to.be.an 'object'
    expect(data.foo).to.be.a 'string'
    expect(data.foo).to.equal 'bar'

    done()

  it 'should be able to compile a template with data', (done) ->

    Home = require '../app/models/home'
    View = require '../app/views/bare_wt'

    view = new View
      model: new Home

    template = view.getTemplateFunction()

    expect(template).to.be.a 'string'
    expect(template).to.equal '<ul id="bar"></ul>\n'

    done()

  it 'should not be able to get template html', (done) ->

    View = require '../app/views/bare'

    view = new View

    templateHtml = view.getTemplateFunction()

    expect(templateHtml).to.equal undefined

    done()

  it 'should be able to get html from a view without a template', (done) ->

    View = require '../app/views/bare'

    view = new View

    html = view.getHtml()

    expect(html).to.be.a 'string'

    done()

  it 'should be able to get html from a view with a template', (done) ->

    View = require '../app/views/bare_wt'

    view = new View

    html = view.getHtml()

    expect(html).to.be.a 'string'

    done()
