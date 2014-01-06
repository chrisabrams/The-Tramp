{exec} = require "child_process"

REPORTER = "spec"

task "test", "run tests", ->

  exec "NODE_ENV=test
    ./node_modules/.bin/mocha
    --compilers coffee:coffee-script
    --reporter #{REPORTER}
    --require coffee-script
    --require test/helper.coffee
    --colors
    --growl
    test/unit/**.coffee
  ", (err, output) ->

    throw err if err
    console.log output
