require 'coffee-script/register'
fs = require 'fs'
path = require 'path'
coffee = require 'coffee-script'
ast_functions = require path.join __dirname, 'ast'


getType = () ->
    return 'coffee-script'

parse = (desc) ->
    filedata = fs.readFileSync desc.filepath
    ast_raw = coffee.nodes(filedata.toString())
    return ast_functions.remove_nodes ast_raw

Plugin =
    getType: getType
    parse: parse
    ast_functions: ast_functions
module.exports = Plugin
