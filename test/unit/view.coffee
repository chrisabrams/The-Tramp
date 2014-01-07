describe 'View - Unit', ->

  it 'should be able to initialize', (done) ->

    View = require '../app/views/bare'

    view = new View

    expect(view).to.be.an 'object'

    done()

  it 'should be able to get html from a view without a template', (done) ->

    View = require '../app/views/bare'

    view = new View

    html = view.getHtml()

    expect(html).to.be.a 'string'

    done()
