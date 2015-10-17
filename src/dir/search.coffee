require 'coffee-script/register'
fs = require 'fs'
path = require 'path'
utils = require './utils'
FileDesc = require './file_descriptor'


###
# Create a list of file descriptor objects by searching the dir
# @param dir string the dir to search
# @return [object] an array of file descriptor objects
###
search = (dir) ->
    ret = []
    if not utils.is.dir(dir)
        return ret

    contents = fs.readdirSync(dir)
    for item in contents
        item = path.resolve(dir, item)
        if utils.is.dir(item)
            ret.concat(search(item))
        else
            if utils.file_supported(item)
                ret.push(new FileDesc(item))
    return ret

module.exports = search
