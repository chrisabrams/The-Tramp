Chaplin = require 'chaplin'

module.exports = (handlers) ->

  return match = (pattern, target, options) ->

    if arguments.length is 2 and typeof target is 'object'

      # Handles cases like `match 'url', controller: 'c', action: 'a'`.
      options = target
      {controller, action} = options
      
      unless controller and action
        throw new Error 'Router#match must receive either target or ' +
          'options.controller & options.action'

    else

      # Handles `match 'url', 'c#a'`.
      if typeof options is 'object'
        {controller, action} = options

        if controller or action
          throw new Error 'Router#match cannot use both target and ' +
            'options.controller / options.action'

      # Separate target into controller and controller action.
      [controller, action] = target.split('#')

    # Create the route.
    route = new Chaplin.Route pattern, controller, action, options

    handlers.push({route: route})
