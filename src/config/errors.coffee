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
        @message = "Required property '" +
        # TODO: finish this class 
