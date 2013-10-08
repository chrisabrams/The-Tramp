module.exports = (grunt) ->

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    banner: '/*! <%= pkg.name %> - v<%= pkg.version %> - ' +
      '<%= grunt.template.today("yyyy-mm-dd") %>\n' +
      '<%= pkg.homepage ? "* " + pkg.homepage + "\\n" : "" %>' +
      '* Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author.name %>;' +
      ' Licensed <%= _.pluck(pkg.licenses, "type").join(", ") %> */\n'

    clean:
      dist: ['dist/', 'tmp/']
      test: ['test/public/js/test.js', 'tmp/']

    coffee:
      dist:
        expand: yes
        cwd: 'app/'
        src: '**/*.coffee'
        dest: 'tmp/'
        ext: '.js'
      test:
        files:
          'test/public/js/test.js': 'test/functional/**/*.coffee'

    commonjs:
      modules:
        cwd: 'tmp/'
        src: ['**/*.js']
        dest: 'tmp/'

    concat:
      devJs:
        files:
          'public/js/app.js': '<%= jsFiles %>'

    copy:
      dist:
        files: [
          {
            expand: true
            cwd: 'app/assets/'
            src: ['**']
            dest: 'public/'
            filter: 'isFile'
          }
        ]

    handlebars:
      dist:
        files: grunt.file.expandMapping(['app/templates/**/*.hbs'], 'tmp/templates/', {
          rename: (destBase, destPath) ->
            return destBase + destPath.split('app/templates/')[1].replace /\.hbs$/, '.js'
        })

    jsFiles: [
      'vendor/scripts/common.js'
      'vendor/scripts/underscore.min.js'
      'vendor/scripts/backbone.js'
      'vendor/scripts/chaplin.js'
      'vendor/scripts/handlebars.js'
      'tmp/**/*.js'
      'vendor/scripts/end.js'
    ]

    livereload:
      options:
        base: 'test',
      files: ['test/public/**/*']

    mocha:
      test:
        src: "http://localhost:4488/index.html"
        mocha:
          ignoreLeaks: false
          timeout: 20000
        run: true

    uglify:
      options:
        mangle: false
      dist:
        files:
          'public/js/app.js': '<%= jsFiles %>'

    watch:
      assets:
        files: ['app/assets/**/*'],
        tasks: ['copy']
        options:
          debounceDelay: 50
      css:
        files: ['app/css/**/*.styl'],
        tasks: ['styles']
        options:
          debounceDelay: 50
      express:
        files: ['server.js']
        tasks: ['express:dev']
        options:
          nospawn: true
      hbs:
        files: ['app/templates/**/*.hbs']
        tasks: ['scripts', 'concat:devJs']
        options:
          debounceDelay: 250
      js:
        files: ['app/**/*.coffee'],
        tasks: ['scripts', 'concat:devJs']
        options:
          debounceDelay: 250

  grunt.loadNpmTasks 'grunt-commonjs'
  grunt.loadNpmTasks 'grunt-commonjs-handlebars'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-cssmin'
  grunt.loadNpmTasks 'grunt-contrib-jshint'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-express-server'
  grunt.loadNpmTasks 'grunt-livereload'
  grunt.loadNpmTasks 'grunt-mocha'

  grunt.registerTask 'styles',  ['stylus', 'concat:distCss']
  grunt.registerTask 'scripts', ['coffee:dist', 'handlebars', 'commonjs']
  #grunt.registerTask 'prep',    ['styles', 'scripts']
  grunt.registerTask 'prep',    ['scripts']
  grunt.registerTask 'b',       ['clean:dist', 'prep', 'concat:devJs', 'copy:dist']
