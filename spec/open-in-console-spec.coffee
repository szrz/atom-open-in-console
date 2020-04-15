OpenInConsole = require '../lib/open-in-console'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "OpenInConsole", ->
  activationPromise = null

  beforeEach ->
    activationPromise = atom.packages.activatePackage('openInConsole')
