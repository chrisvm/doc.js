require 'coffee-script/register'

should = require 'should'
path = require 'path'
temp = require 'temp'
fs = require 'fs'
temp.track()
plug_dir = path.resolve path.join __dirname, '../src/plugins'
ObjTypes = require path.join plug_dir, 'obj_types'


describe 'ObjTypes', () ->

    describe '#create', () ->
        it 'should create a simple type', () ->
            types = new ObjTypes()
            test_case =
                fields:
                    a:
                        value: "something",
                        type: "string"
                    registered: ["a"]

            SimpleType = types.create("SimpleType")
            SimpleType.field("a").value("something")
            types.json("SimpleType").should.deepEqual(test_case)

        it 'should coerce array type from object', () ->
            types = new ObjTypes()
            TestType = types.create("TestType")
            TestType.field("arr").value([])
            TestType.field("arr").type().should.equal("array")
