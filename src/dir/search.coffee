require 'coffee-script/register'
fs = require 'fs'
path = require 'path'
utils = require './utils'
FileDesc = require './file_descriptor'
PlugBase = require '../plugins/plug_base'

###
# Create a list of file descriptor objects by searching the dir
# @param dir string the dir to search
# @return [object] an array of file descriptor objects
###
search = (dir) ->
    pl_base = PlugBase.default_plugins()
    recv = (dir, root) ->
        ret = []
        if not utils.is.dir(dir)
            return ret

        contents = fs.readdirSync(dir)
        for item in contents
            item = path.resolve(dir, item)
            if utils.is.dir(item)
                ret.concat(recv(item, root))
            else
                if pl_base.file_supported(item)
                    new_file = new FileDesc(root, item)
                    ret.push pl_base.parse new_file
        return ret
    return recv dir, dir

module.exports = search
