fs = require 'fs'
path = require 'path'

###
# Create a list of file descriptor objects by searching the dir
# @param dir string the dir to search
# @return [object] an array of file descriptor objects
###
search = (dir) ->
