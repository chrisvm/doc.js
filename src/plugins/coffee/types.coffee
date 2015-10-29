require 'coffee-script/register'
path = require 'path'
ObjTypes = require path.join __dirname, '../obj_types'


types = new ObjTypes()

# CommentType
CommentType = types.create("CommentType")
CommentType.field("comment").type("string")
CommentType.field("children").value([])

FunctionType = types.create("FunctionType")
FunctionType.field("variable")
FunctionType.field("value")
FunctionType.field("children").value(["variable", "value"])


module.exports = types
