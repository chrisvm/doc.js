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

        it 'should a file descriptor object for .coffee files', (done) ->
            temp.mkdir 'coffee_temp_files', (err, dirpath) ->
                filename = path.join dirpath, 'test.coffee'
                fs.writeFileSync filename, 'x = 10'
                search(dirpath).length.should.equal(1)
                done()
