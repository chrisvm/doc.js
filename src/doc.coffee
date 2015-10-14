#!/usr/bin/env node
require 'coffee-script/register'
config = require './src/config/config'

main = () ->
    # get current dir
    cwd = process.cwd()
    cnf = config.read cwd

    # if config not found, throw error
    if not cnf?
        throw 'Config not found error'
    console.log cnf
main()
