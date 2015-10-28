require 'coffee-script/register'
fs = require 'fs'
path = require 'path'
config = require '../config/config'
dir_utils = require '../dir/utils'
config_exception = require '../config/errors'


class PlugBase
    constructor: (plugin_dir) ->
        @pl_dir = plugin_dir
        @plugins = {}
        @supported_files = []
        this.init()

    init: () ->
        dir_contents = fs.readdirSync this.pl_dir
        for item in dir_contents
            abs_item = path.resolve this.pl_dir, item
            if dir_utils.is.dir abs_item
                # get dir and look for module def file
                dir_def = config.json_yml_config abs_item, 'def'
                if dir_def?
                    dir_def.plug_path = abs_item
                    try
                        this.process_plugin dir_def
                    catch
                        console.log("Warning: error adding plugin in " + abs_item)

    process_plugin: (plug_def) ->
        validation = config.valid_plugin plug_def
        if typeof(validation) is "string"
            throw new config_exception.RequiredPropertyNotFoundError validation, plug_def
        plugin = {}
        plugin.def = plug_def
        plugin.methods = require path.join plug_def.plug_path, 'plugin'
        this.plugins[plug_def.support_ext] = plugin
        this.supported_files.push plug_def.support_ext

    parse: (desc) ->
        if not desc.ext in this.supported_files
            return null
        desc.parsed = this.plugins[desc.ext].methods.parse(desc)
        return desc

    get_type: (desc) ->
        if not desc.ext in this.supported_files
            return null
        return this.plugins[desc.ext].getType()

    file_supported: (filepath) ->
        ext = path.parse(filepath).ext
        if ext in this.supported_files
            return true
        else
            return false

    @default_plugins: () ->
        plugin_dir = __dirname
        ret = new PlugBase path.resolve plugin_dir
        return ret

module.exports = PlugBase
