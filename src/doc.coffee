#!/usr/bin/env node
require 'coffee-script/register'
config = require './src/config/config'
dir_exception = require './src/dir/errors'
fs = require 'fs'
path = require 'path'
search = require './src/dir/search'
cli_frontend = require './src/config/cli'

main = () ->
    # get opts from cli
    program = cli_frontend.opts_parse()

    if program.dir?
        # get base path
        cwd = path.dirname(program.dir)
        cnf = config.validate(cwd)
    else
        # set config_dir to current dir
        cwd = process.cwd()
        # get config
        cnf = config.validate(cwd)

    # check input dir exists
    if not fs.statSync(cnf.input_dir).isDirectory()
        throw new dir_exception.InputDirNotFoundError(cnf.input_dir)

    # recurse through the input_dir looking for js and yml files
    dir_contents = search path.resolve cnf.input_dir

    # TODO: start with the ast normalization and processing
main()
