require 'coffee-script/register'
path = require 'path'
fs = require 'fs'
esprima = require 'esprima'


class FileDescriptor
    constructor: (root, filepath) ->
        @filepath = filepath
        @name = path.parse(filepath).base
        @ext = path.parse(filepath).ext
        @parsed = this.parse()
        @root = root
        @from_root = path.relative(root, filepath)

    type: () ->
        if not this.ext?
            return null
        if this.ext is '.coffee'
            return 'coffee-script'
        else if this.ext is '.js'
            return 'javascript'
        else
            return null

    parse: () ->
        if not this.filepath?
            return null
        type = this.type()
        filedata = fs.readFileSync(this.filepath)

        if type is 'coffee-script'
            # parse coffescript
            return {}
        else if type is 'javascript'
            # parse javascript
            return esprima.parse(filedata)

module.exports = FileDescriptor
