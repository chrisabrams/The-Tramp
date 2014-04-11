{exec} = require "child_process"

REPORTER = "spec"

task "functional", "run tests", ->

  exec "NODE_ENV=test
    ./node_modules/.bin/mocha
    --compilers coffee:coffee-script
    --reporter #{REPORTER}
    --require coffee-script
    --require test/helper.coffee
    --colors
    --growl
    test/functional/**.coffee
  ", (err, output) ->

    throw err if err
    console.log output

task "single", "run tests", ->

  exec "NODE_ENV=test
    ./node_modules/.bin/mocha
    --compilers coffee:coffee-script
    --reporter #{REPORTER}
    --require coffee-script
    --require test/helper.coffee
    --colors
    --growl
    test/unit/collection_view.coffee
  ", (err, output) ->

    throw err if err
    console.log output

task "test", "run tests", ->

  exec "NODE_ENV=test
    ./node_modules/.bin/mocha
    --compilers coffee:coffee-script
    --reporter #{REPORTER}
    --require coffee-script
    --require test/helper.coffee
    --colors
    --growl
    test/unit/**.coffee test/functional/**.coffee
  ", (err, output) ->

    throw err if err
    console.log output

task "unit", "run tests", ->

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

task "unitcollection_view", "run tests", ->

  exec "NODE_ENV=test
    ./node_modules/.bin/mocha
    --compilers coffee:coffee-script
    --reporter #{REPORTER}
    --require coffee-script
    --require test/helper.coffee
    --colors
    --growl
    test/unit/collection_view.coffee
  ", (err, output) ->

    throw err if err
    console.log output

task "unitgenerator", "run tests", ->

  exec "NODE_ENV=test
    ./node_modules/.bin/mocha
    --compilers coffee:coffee-script
    --reporter #{REPORTER}
    --require coffee-script
    --require test/helper.coffee
    --colors
    --growl
    test/unit/generator.coffee
  ", (err, output) ->

    throw err if err
    console.log output

task "unitmodel", "run tests", ->

  exec "NODE_ENV=test
    ./node_modules/.bin/mocha
    --compilers coffee:coffee-script
    --reporter #{REPORTER}
    --require coffee-script
    --require test/helper.coffee
    --colors
    --growl
    test/unit/model.coffee
  ", (err, output) ->

    throw err if err
    console.log output

task "unitview", "run tests", ->

  exec "NODE_ENV=test
    ./node_modules/.bin/mocha
    --compilers coffee:coffee-script
    --reporter #{REPORTER}
    --require coffee-script
    --require test/helper.coffee
    --colors
    --growl
    test/unit/view.coffee
  ", (err, output) ->

    throw err if err
    console.log output
