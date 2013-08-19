# oauthd
# http://oauth.io
#
# Copyright (c) 2013 thyb, bump
# Licensed under the MIT license.

Path = require 'path'
config = require "./config"
async = require "async"
config.rootdir = Path.normalize __dirname + '/..'

# initialize plugins
exports.plugins = plugins = require "./plugins"
plugins.init()

# start server
exports.server = server = require './server'
async.series [
	plugins.data.db.providers.getList,
	server.listen
], (err) ->
	if err
		console.error 'Error while initialisation', err.stack.toString()
		plugins.data.emit 'server', err
