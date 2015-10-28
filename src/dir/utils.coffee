fs = require 'fs'
path = require 'path'

Utils =
    is:
        dir: (path) ->
            return fs.lstatSync(path).isDirectory()

        file: (path) ->
            return fs.lstatSync(path).isFile()

module.exports = Utils
