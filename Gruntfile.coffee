module.exports = (grunt) ->
	# config grunt
	config =
		coffee:
			compile:
				files:
					'test/configuration.js': 'test/configuration.coffee'

				options:
					bare: true

		clean:
			test_js: [
				'test/*.js'
			]


	grunt.initConfig(config)

	# load tasks
	grunt.loadNpmTasks('grunt-contrib-coffee')
	grunt.loadNpmTasks('grunt-contrib-clean')

	# register tasks
	grunt.registerTask('default', ['clean', 'init'])
	grunt.registerTask('init', ['coffee'])
