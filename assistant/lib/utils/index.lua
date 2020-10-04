-----------------------------------------------------------------------------
-- Collection of utilities used internally
-----------------------------------------------------------------------------

return {
  with           = require(BASE(..., 'with')),
  assign         = require(BASE(..., 'assign')),
  growTable      = require(BASE(..., 'growTable')),
  raiseError     = require(BASE(..., 'raiseError')),
  defineClass    = require(BASE(..., 'defineClass')),
  checkArguments = require(BASE(..., 'checkArguments')),
}