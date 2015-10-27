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

    # get base path
    if program.dir?
        cwd = path.resolve(program.dir)
    else
        cwd = process.cwd()

    # get config
    cnf = config.validate(cwd)

    # check input dir exists
    input_dir = path.join cwd, cnf.input_dir
    if not fs.statSync(input_dir).isDirectory()
        throw new dir_exception.InputDirNotFoundError(cnf.input_dir)

    # recurse through the input_dir looking for js and yml files
    dir_contents = search input_dir

    console.log(dir_contents[0])
    # TODO: plugin arquitecture needs to be implemented before starting
    ##      with js parsing needs

    # TODO: js parsing - comments need to be attached to the corresponding
    ##      ast nodes

    # TODO: start with the ast normalization and processing
main()
