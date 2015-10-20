require 'coffee-script/register'
path = require 'path'
fs = require 'fs'
coffee = require 'coffee-script'
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
            return coffee.nodes(filedata.toString())
        else if type is 'javascript'
            # parse javascript
            return esprima.parse(filedata)

    ast_clean: () ->
        ignore = ['locationData']
        recv = (obj) ->
            if Array.isArray(obj)
                ret = []
                for item in obj
                    ret.push(recv(item))
                return ret
            else if typeof(obj) is 'object'
                ret = {}
                for key,value of obj
                    if key not in ignore
                        ret[key] = recv(value)
                return ret
            else
                return obj
        return recv(this.parsed)

module.exports = FileDescriptor
