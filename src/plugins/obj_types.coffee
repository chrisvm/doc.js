require 'coffee-script/register'

basetype = () ->
    ret =
        fields:
            registered: []
    return ret

basefield = () ->
    ret =
        value: null
        type: null
    return ret

class ObjTypes
    constructor: () ->
        @types = {}
        @registered = []

    create: (typename) ->
        # overwrites already created type of same name
        types = this.types
        types[typename] = basetype()
        this.registered.push typename

        field = (fieldname) ->
            # if already created, dont overwrite
            if not types[typename].fields[fieldname]?
                types[typename].fields[fieldname] = basefield()
                types[typename].fields.registered.push fieldname

            # field.value setter/getter
            value = (value) ->
                if types[typename].fields[fieldname]? and not value?
                    return types[typename].fields[fieldname].value
                types[typename].fields[fieldname].value = value
                value_type = typeof(value)
                if value_type is 'object' and Array.isArray(value)
                    value_type = 'array'
                types[typename].fields[fieldname].type = value_type
                return field(fieldname)

            # field.type getter/setter
            type = (type) ->
                if types[typename].fields[fieldname]? and not type?
                    return types[typename].fields[fieldname].type
                types[typename].fields[fieldname].type = type
                return field(fieldname)

            # returns an object with methods referencing the created field
            fieldret =
                value: value
                type: type
            return fieldret

        # returns an object with methods referencing the created type
        # with its fields
        createret =
            field: field
        return createret

    # return the json data of the type
    json: (typename) ->
        if typename not in this.registered
            return null
        return this.types[typename]

module.exports = ObjTypes
