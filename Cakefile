
{spawn, exec} = require 'child_process'
util = require 'util'

task 'spec', 'Run the spec files', ->
  util.log 'Running specs'
  jasmine()

task 'build', 'Build Coffee and Less files into js and css files', ->
  exec './node_modules/.bin/coffee --compile --join ./public/js/app.js lib/client/*.coffee app/models/*.coffee', (error,stdout,stderr) ->
    util.print error
    util.print stdout
    util.print stderr

  lessc = spawn( './node_modules/.bin/lessc', [ 'public/css/less/master.less', 'public/css/master.css' ] )
  out_process lessc

task 'docs', 'Build the docco docs', ->
  exec './node_modules/.bin/docco server.coffee lib/**/*.coffee', (error,stdout,stderr) ->
    util.print error
    util.print stdout
    util.print stderr


jasmine = ( options = '', dir = './spec' ) ->
  process = spawn( './node_modules/.bin/jasmine-node', [ '--coffee', options, dir ] )
  out_process process

out_process = ( process ) ->
  process.stdout.on 'data', (data) -> util.print data
  process.stderr.on 'data', (data) -> util.print data
