fs = require 'fs'
path = require 'path'
supported_files = ['.js', '.coffee']

Utils =
    is:
        dir: (path) ->
            return fs.lstatSync(path).isDirectory()

        file: (path) ->
            return fs.lstatSync(path).isFile()

    file_supported: (filepath) ->
        ext = path.parse(filepath).ext
        if ext in supported_files
            return true
        else
            return false

Utils.file_supported.supported = supported_files
module.exports = Utils
