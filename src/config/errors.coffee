class ConfigurationNotFoundError
    constructor: (dir) ->
        @dir = dir
        @message = "Configuration file not found at directory '"
        @message += @dir + "'"
        @toString = () ->
            return "ConfigurationNotFoundError:" + @message

class RequiredPropertyNotFoundError
    constructor: (field, objName) ->
        @field = field
        @obj = objName
        @message = "Required property '" + field + "' in "
        @message += objName
        @toString = () ->
            return @message

module.exports =
    ConfigurationNotFoundError: ConfigurationNotFoundError
    RequiredPropertyNotFoundError: RequiredPropertyNotFoundError
