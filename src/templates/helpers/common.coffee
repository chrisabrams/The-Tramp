module.exports = (Handlebars) ->

  Handlebars.registerHelper 'json', (context) ->
    JSON.stringify context
