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

    ast_clean: () ->
        if not this.parsed?
            return ''
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
        this.parsed = recv(this.parsed)

module.exports = FileDescriptor
