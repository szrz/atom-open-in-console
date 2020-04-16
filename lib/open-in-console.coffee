{CompositeDisposable} = require 'atom'
exec = require('child_process').exec
fs = require 'fs'

module.exports =
	config:
		consolePath:
			type: 'string'
			default: 'C:\\Windows\\System32\\cmd.exe'

	# Register show and open
	activate: ->
		@disposables = new CompositeDisposable
		@disposables.add atom.commands.add('.tree-view .selected', {
			'open-in-console:open': (event) => @openConsole(event.currentTarget)
		})

	# Cleanup
	deactivate: ->
		@disposables?.dispose()
		@disposables = null

	# Extract the path from the target: can be a tree-view or tab item.
	getPath: (target) -> return target.getPath?() ? target.item?.getPath()

	# Call native/shell open item method for the given view.
	openConsole: (target) ->
		path = target.querySelector('[data-path]').dataset.path
		isDir = fs.lstatSync(path).isDirectory()
		if !isDir
			path = path.split(/\\[^\\]*\.[A-Za-z0-9]*$/)
		exec "cd \"#{path}\" && start #{atom.config.get('open-in-console.consolePath')}"
