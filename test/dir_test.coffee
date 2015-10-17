require 'coffee-script/register'

should = require 'should'
path = require 'path'
temp = require 'temp'
fs = require 'fs'
temp.track()
dir_dir = '../src/dir'

describe 'DirMethods', () ->
    search = require path.join dir_dir, 'search'
    utils = require path.join dir_dir, 'utils'

    describe '#search', () ->
        it 'should return empty array on empty dir', (done) ->
            temp.mkdir 'somepath', (err, dirpath) ->
                search(dirpath).should.deepEqual([])
                done()

        it 'should a file descriptor object for .js files', (done) ->
            temp.mkdir 'js_temp_files', (err, dirpath) ->
                filename = path.join dirpath, 'test.js'
                fs.writeFileSync filename, 'var x = 10;'
                search(dirpath).length.should.equal(1)
                done()

    describe '#utils', () ->
        describe '#file_supported()', () ->
            test_case = 'foo.bar'

            it 'should give false for a not supported file', () ->
                utils.file_supported(test_case).should.equal(false)

            for supp_file in utils.file_supported.supported
                message = 'should return true when given a "'
                message += supp_file
                message += '" ext file'
                correct = 'foo' + supp_file
                it message, () ->
                    utils.file_supported(correct).should.equal(true)
