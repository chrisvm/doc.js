fs = require 'fs'
coffee = require 'coffee-script'


getType = () ->
    return 'coffee-script'

parse = (desc) ->
    filedata = fs.readFileSync desc.filepath
    return coffee.nodes(filedata.toString())


Plugin =
    getType: getType
    parse: parse
module.exports = Plugin
