require 'coffee-script/register'
path = require 'path'
ObjTypes = require path.join __dirname, '../obj_types'


types = new ObjTypes()

# CommentType
CommentType = types.create("CommentType")
CommentType.field("comment").type("string")
CommentType.field("children").value([])


module.exports = types
