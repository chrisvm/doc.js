#!/usr/bin/env node
require 'coffee-script/register'
colors = require 'colors'
config = require './src/config/config'
dir_exception = require './src/dir/errors'
fs = require 'fs'
path = require 'path'
search = require './src/dir/search'
PlugBase = require './src/plugins/plug_base'
cli_frontend = require './src/config/cli'


main = () ->
    # get opts from cli
    program = cli_frontend.opts_parse()

    # init plugins
    if program.verbose is true
        PlugBase.force_verbose()
    pl_base = PlugBase.default_plugins()

    # get base path
    if program.dir?
        cwd = path.resolve(program.dir)
    else
        cwd = process.cwd()

    # get config
    try
        cnf = config.validate(cwd)
    catch error
        if program.verbose is true
            console.trace(error.toString().red)
        else
            console.log(error.toString().red)
        return

    # check input dir exists
    input_dir = path.join cwd, cnf.input_dir
    if not fs.statSync(input_dir).isDirectory()
        if program.verbose is true
            console.log((new dir_exception.InputDirNotFoundError(cnf.input_dir)))
        else
            console.log((new dir_exception.InputDirNotFoundError(cnf.input_dir)).toString().red)

    # recurse through the input_dir looking for js and yml files
    dir_contents = search input_dir

    console.log(JSON.stringify(dir_contents[0].parsed, null, 4))
    # TODO: add functions for creating test plugins for unit testing
    # TODO: add tests for PlugBase class
    # TODO: js parsing - comments need to be attached to the corresponding
    ##      ast nodes

    # TODO: start with the ast normalization and processing
main()
