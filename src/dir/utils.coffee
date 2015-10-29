fs = require 'fs'
path = require 'path'

Utils =
    is:
        dir: (path) ->
            return fs.lstatSync(path).isDirectory()

        file: (path) ->
            return fs.lstatSync(path).isFile()

        equal_obj: (a, b) ->
            for prop of a
                if not prop of b
                    return false
                if a[prop] isnt b[prop]
                    return false
            return true

module.exports = Utils
