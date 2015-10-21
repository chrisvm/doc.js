###
# @class Person
# This class describes a person structure, with common methods. Used as
# test source for doc creation
###
class Person
    ###
    # Creates a new person Object
    # @param name string the name of the person
    # @param age integer the age of the person
    ###
    constructor: (name, age) ->
        @name = name
        @age = age

    ###
    # Get a string with a hello message
    # @return string the hello message
    ###
    hello: () ->
        return 'Hello, my name is ' + this.name

    ###
    # Get a string with a detailed description
    # @param inline bool if to create a two line description
    # @return string the description
    ###
    details: (inline) ->
        ret = 'Name: ' + this.name + ' '
        if inline
            ret += '\n'
        ret += 'Age: ' + this.age
        return ret
