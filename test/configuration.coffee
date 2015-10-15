require 'coffee-script/register'

should = require 'should'
path = require 'path'
temp = require 'temp'
fs = require 'fs'
temp.track()
config_dir = '../src/config'

# describe the Configuration test suite
describe "Configuration", () ->
    utils = require path.join config_dir, 'utils'
    config = require path.join config_dir, 'config'

    # Configuration utils.validate.arrayOfStrings
    describe "#utils.validate.arrayOfStrings()", () ->
        it 'should return false when given a number', () ->
            utils.valid.arrayOfStrings(1).should.equal(false)

        it 'should return false when given a string', () ->
            utils.valid.arrayOfStrings('1').should.equal(false)

        it 'should return false when given a boolean', () ->
            utils.valid.arrayOfStrings(false).should.equal(false)

        it 'should return false when given an object', () ->
            utils.valid.arrayOfStrings({foo: 'something'}).should.equal(false)

        it 'should return false when given an empty array', () ->
            utils.valid.arrayOfStrings([]).should.equal(false)

        it 'should return true for a list of strings', () ->
            test_case = ['1', '2', '3']
            utils.valid.arrayOfStrings(test_case).should.equal(true)

    # Configuration utils.pathToFilename
    describe '#utils.pathToFilename()', () ->
        it 'should return null when not given a string', () ->
            test_cases = [1, [], false, {}]
            for test_case in test_cases
                should.not.exist(utils.pathToFilename(test_case))

        it 'should return a correctly changed string for a correct path', () ->
            test_case = 'path/to/file'
            correct = 'path-to-file'
            utils.pathToFilename(test_case).should.equal(correct)

        it 'should correctly handle filenames with underscores', () ->
            test_case = 'path/to/file_with_underscores'
            correct = 'path-to-file_with_underscores'
            utils.pathToFilename(test_case).should.equal(correct)

        it 'should ignore leading slash', () ->
            test_case = '/path/to/file'
            correct = 'path-to-file'
            utils.pathToFilename(test_case).should.equal(correct)

        it 'should handle spaces in dirs with dot', () ->
            test_case = '/path with/spaces/file'
            correct = 'path.with-spaces-file'
            utils.pathToFilename(test_case).should.equal(correct)

    describe "#utils.validate.hasRequired()", () ->
        test_conf = foo: 1
        correct = {}
        for field in utils.valid.hasRequired.fields
            correct[field] = 'somestring'
            message = 'it should give false when field "' + field + '" is missing'
            it message, () ->
                utils.valid.hasRequired(test_conf).should.equal(false)

        it 'should give true when all the required fields are present'
    describe '#read()', () ->
        docjs_config = 'docjs'
        it 'should give error when config file not found', (done) ->
            temp.mkdir 'somepath', (err, dirPath) ->
                should.not.exist config.read dirPath
                done()

        it 'should read yaml config files', (done) ->
            temp.mkdir 'somepath', (err, dirPath) ->
                test_case = 'foo: 1\n'
                correct = (foo: 1)
                filename = path.join dirPath, docjs_config + '.yml'
                fs.writeFile filename, test_case, (err) ->
                    if err?
                        throw err
                    config.read(dirPath).should.deepEqual(correct)
                    done()

        it 'should read json files', (done) ->
            temp.mkdir 'somepath', (err, dirPath) ->
                test_case = '{\n\t"foo": 1\n}\n'
                correct = (foo: 1)
                filename = path.join dirPath, docjs_config + '.json'
                fs.writeFile filename, test_case, (err) ->
                    if err?
                        throw err
                    config.read(dirPath).should.deepEqual(correct)
                    done()
