module.exports = (grunt) ->
	# config grunt
	config =
		coffee:
			compile:
				files:
					'test/configuration.js': 'test/configuration.coffee'
					'doc.js': 'src/doc.coffee'

				options:
					bare: true

		clean:
			test_js: [
				'test/*.js'
			]

		watch:
			coffee:
				files: ['**/*.coffee']
				tasks: ['newer:coffee']

	grunt.initConfig config

	# load tasks
	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-clean'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'grunt-newer'

	# register tasks
	grunt.registerTask 'default', ['watch']
	grunt.registerTask 'init', ['coffee']
