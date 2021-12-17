-----------------------------------------------------------------------------
-- Collection of utilities used internally
-----------------------------------------------------------------------------


raiseError = require(BASE(..., 'raiseError'))

local utils = {
  with           = require(BASE(..., 'with')),
  assign         = require(BASE(..., 'assign')),
  growTable      = require(BASE(..., 'growTable')),
  fallbacks      = require(BASE(..., 'fallbacks')),
  defineClass    = require(BASE(..., 'defineClass')),
  checkArguments = require(BASE(..., 'checkArguments')),
}

return utils
