class PlugBase
    constructor: (plugin_dir) ->
        @pl_dir = plugin_dir
        @init()

    init: () ->
        # TODO: finish parsing pl_dir for plugins
        
    file_supported: (filepath) ->
        # TODO: finish moving this method from dir/utils

pl_dir = '.'
pl_base = new PlugBase(pl_dir)
module.exports = pl_base
