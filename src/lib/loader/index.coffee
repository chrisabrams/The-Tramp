_ = require 'underscore'

module.exports = (__app, paths = []) ->

  defaultPaths = [
    {
      name: 'backbone'
      path: process.cwd() + '/node_modules/chaplin/node_modules/backbone'
    }
    {
      name: 'chaplin'
      path: 'chaplin'
    }
    {
      name: 'underscore'
      path: 'underscore'
    }
  ]

  allPaths = defaultPaths.concat paths

  loader = (->
    modules = {}
    cache = {}
    dummy = ->
      ->

    initModule = (name, definition) ->
      module =
        id: name
        exports: {}

      definition module.exports, dummy(), module
      exports = cache[name] = module.exports
      exports

    loader = (path) ->
      return cache[path] if cache.hasOwnProperty(path)
      return initModule(path, modules[path]) if modules.hasOwnProperty(path)
      
      namedPaths     = []
      containedPaths = []

      # Determine where item belongs
      _.each allPaths, (item) ->

        if item.contains
          containedPaths.push item

        else
          namedPaths.push item

      # Go through regular named paths first
      namedPath = _.where namedPaths, {name: path}

      if namedPath.length > 0
        return require namedPath[0].path

      # Go through containedPaths next
      containedPath = _.filter containedPaths, (item) ->

        if path.indexOf(item.name) > -1
          return item

      if containedPath.length > 0
        return require(containedPath[0].path + '/' + path)

      # Must be an app module
      require __app + "/" + path

    loader.register = (bundle, fn) ->
      modules[bundle] = fn

    loader
  )()

  return loader
