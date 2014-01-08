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
        cwd: 'src/'
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
          'test/public/js/the-tramp.js': '<%= jsFiles %>'

    handlebars:
      dist:
        files:
          "test/app/templates/home.js": "test/app/templates/home.hbs"

    livereload:
      options:
        base: 'test',
      files: ['test/public/**/*']

    jsFiles: [
      'tmp/**/*.js'
    ]

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
          'dist/the-tramp.js': '<%= jsFiles %>'
      test:
        options:
          beautify: true
        files:
          'test/public/js/the-tramp.js': '<%= jsFiles %>'

    watch:
      src:
        files: ['src/**/*.coffee']
        tasks: ['t']
        options:
          debounceDelay: 250

      test:
        files: ['test/functional/**/*.coffee']
        tasks: ['t']
        options:
          debounceDelay: 250

  grunt.loadNpmTasks 'test/modules/handlebars'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-livereload'
  grunt.loadNpmTasks 'grunt-mocha'
