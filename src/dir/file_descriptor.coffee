require 'coffee-script/register'
path = require 'path'
fs = require 'fs'


class FileDescriptor
    constructor: (root, filepath) ->
        @filepath = filepath
        @name = path.parse(filepath).base
        @ext = path.parse(filepath).ext
        @parsed = null
        @root = root
        @from_root = path.relative(root, filepath)

module.exports = FileDescriptor
