Application = require './application'
routes      = require './routes'

$ ->

  new Application {
    title: 'oogabooga',
    controllerSuffix: '',
    routes
  }
