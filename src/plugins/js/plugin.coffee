fs = require 'fs'
esprima = require 'esprima'


getType = () ->
    return 'javascript'

parse = (desc) ->
    filedata = fs.readFileSync desc.filepath
    options =
        comment: true
        loc: true
    return esprima.parse filedata, options

Plugin =
    getType: getType
    parse: parse
module.exports = Plugin
