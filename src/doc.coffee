#!/usr/bin/env node
require 'coffee-script/register'
config = require './src/config/config'
dir_exception = require './src/dir/errors'
fs = require 'fs'
path = require 'path'
search = require './src/dir/search'
PlugBase = require './src/plugins/plug_base'
cli_frontend = require './src/config/cli'


main = () ->
    # init plugins
    pl_base = PlugBase.default_plugins()

    # get opts from cli
    program = cli_frontend.opts_parse()

    # get base path
    if program.dir?
        cwd = path.resolve(program.dir)
    else
        cwd = process.cwd()

    # get config
    try
        cnf = config.validate(cwd)
    catch error
        console.log(error.toString())
        return

    # check input dir exists
    input_dir = path.join cwd, cnf.input_dir
    if not fs.statSync(input_dir).isDirectory()
        console.log((new dir_exception.InputDirNotFoundError(cnf.input_dir)).toString())

    # recurse through the input_dir looking for js and yml files
    dir_contents = search input_dir

    console.log(dir_contents)
    # TODO: js parsing - comments need to be attached to the corresponding
    ##      ast nodes

    # TODO: start with the ast normalization and processing
main()
