class InputDirNotFoundError
    constructor: (dir_name) ->
        @dir = dir_name
        @message = "Directory '" + @dir + "' not found"
        @toString = () ->
            return @message

module.exports =
    InputDirNotFoundError: InputDirNotFoundError
