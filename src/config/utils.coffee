path = require('path')
requiredFields = [
    'input_dir',
    'output_dir'
]

Validation =
    # check if mixed is an array of strings
    arrayOfStrings: (mixed) ->
        if Array.isArray(mixed) and mixed.length isnt 0
            for item in mixed
                if typeof(item) isnt 'string'
                    return false
            return true
        return false

    # check if conf has required fields
    hasRequired: (conf) ->
        for field in requiredFields
            if not field of conf
                return false
        return true

Misc =
    # convert path to name of file
    pathToFilename: (pathstring) ->
        if typeof(pathstring) isnt 'string'
            return null

        parsed = path.parse(pathstring)
        ret = pathstring.replace(parsed.root, '')
        ret = ret.replace(/\ +/g, '.')
        ret = ret.replace(/\/+/g, '-')
        return ret

Validation.hasRequired.fields = requiredFields
Misc.valid = Validation
module.exports = Misc
