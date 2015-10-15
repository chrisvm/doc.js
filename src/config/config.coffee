require 'coffee-script/register'
path = require 'path'
fs = require 'fs'
YAML = require 'yamljs'
utils = require './utils'

Config =
    # read the config file in dir
    read: (dir) ->
        # get the contents of dir
        contents = fs.readdirSync dir

        config_file = 'docjs'
        yaml_file = config_file + '.yml'
        json_file = config_file + '.json'

        # check if config file in contents
        if yaml_file in contents
            abs_path = path.join dir, yaml_file
            config_content = fs.readFileSync abs_path, 'utf8'
            config_content = YAML.parse(config_content)
        else if json_file in contents
            config_content = require path.join dir, json_file
        else
            return null

        # config_content contains the config object
        return config_content

    validate: (dir) ->

    utils: utils
    
module.exports = Config
