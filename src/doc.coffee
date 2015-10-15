#!/usr/bin/env node
require 'coffee-script/register'
config = require './src/config/config'
search = require './src/dir/search'

main = () ->
    # get current dir
    cwd = process.cwd()

    # get config
    cnf = config.validate(cwd)

    # recurse through the input_dir looking for js and yml files
    dir_contents = search cnf.input_dir
main()
