require 'coffee-script/register'
path = require 'path'
fs = require 'fs'
config_exception = require './errors'
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
        # try to read conf in dir
        cnf = Config.read(dir)

        # if not found, error
        if not cnf?
            throw new config_exception.ConfigurationNotFoundError(dir)

        # look for required fields
        if not utils.valid.hasRequired(cnf)
            throw new config_exception.RequiredPropertyNotFoundError
        return cnf

    json_yml_config: (dir, filename) ->
        # read dir contents
        dir_contents = fs.readdirSync(dir)

        # look for yaml or json files with name
        # <filename>.json or <filename>.yml
        for file in dir_contents
            if path.basename(file, '.json') is filename
                # found json file
                return JSON.parse(fs.readFileSync(file, 'utf8'))
            else if path.basename(file, '.yml') is filename
                return YAML.parse(fs.readFileSync(file, 'utf8'))
        return null

    utils: utils

module.exports = Config
