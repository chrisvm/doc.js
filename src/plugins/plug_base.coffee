require 'coffee-script/register'
fs = require 'fs'
colors = require 'colors'
path = require 'path'
config = require '../config/config'
dir_utils = require '../dir/utils'
config_exception = require '../config/errors'


class PlugBase
    @disabled: []
    @is_disabled: (plug_def) ->
        for dbled in PlugBase.disabled
            if dir_utils.is.equal_obj dbled, plug_def
                return true
        return false

    @_force_verbose: false
    @force_verbose: () ->
        PlugBase._force_verbose = not PlugBase._force_verbose

    constructor: (plugin_dir, opts) ->
        opts = if not opts? then {} else opts
        @pl_dir = plugin_dir
        @plugins = {}
        @supported_files = []
        @verbose = if PlugBase._force_verbose or opts.verbose is true then true else false
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
                    # if plugin is disabled, skip
                    if PlugBase.is_disabled dir_def
                        if this.verbose is true
                            message = "Warning: trying to load disabled plugin "
                            message += "'" + dir_def.module_name + "'"
                            console.log(message.yellow)
                        continue

                    try
                        this.process_plugin dir_def
                    catch error
                        base_msg = "Warning: error adding plugin "
                        base_msg += "'" + dir_def.module_name + "'"
                        base_msg += " in " + abs_item
                        if this.verbose is true
                            base_msg += "\n"
                            base_msg += "    -> " + error.toString()
                        console.log(base_msg.yellow)
                        # add to global plugin disabled list so when another PlugBase
                        # object is created in the same session it doesnt try to open
                        # the same plugin
                        PlugBase.disabled.push dir_def

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

    @default_plugins: (opts) ->
        plugin_dir = __dirname
        if opts?
            ret = new PlugBase (path.resolve plugin_dir), opts
        else
            ret = new PlugBase (path.resolve plugin_dir)
        return ret

module.exports = PlugBase
