require('coffee-script/register')

should = require("should")
path = require("path")
config_dir = '../src/config'

# describe the Configuration test suite
describe "Configuration", () ->
    utils = require(path.join(config_dir, 'utils'))

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
