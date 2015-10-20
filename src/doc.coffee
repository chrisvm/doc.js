#!/usr/bin/env node
require 'coffee-script/register'
config = require './src/config/config'
fs = require 'fs'
path = require 'path'
search = require './src/dir/search'

main = () ->
    # get current dir
    cwd = process.cwd()

    # get config
    cnf = config.validate(cwd)

    # check input dir exists
    if not fs.statSync(cnf.input_dir).isDirectory()
        throw 'InputDirNotFoundError'

    # recurse through the input_dir looking for js and yml files
    search.root = cnf.input_dir
    dir_contents = search path.resolve cnf.input_dir
    console.log(dir_contents)
main()
