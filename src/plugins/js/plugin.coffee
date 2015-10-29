require 'coffee-script/register'
fs = require 'fs'
path = require 'path'
esprima = require 'esprima'
ast_functions = require path.join __dirname, 'ast'


getType = () ->
    return 'javascript'

parse = (desc) ->
    filedata = fs.readFileSync desc.filepath
    options =
        comment: true
        loc: false
    raw_ast = esprima.parse filedata, options
    return ast_functions.attach_comments raw_ast

Plugin =
    getType: getType
    parse: parse
    ast_functions: ast_functions
module.exports = Plugin
