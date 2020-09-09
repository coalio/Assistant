-----------------------------------------------------------------------------
-- Collection of utilities used internally
-----------------------------------------------------------------------------

return {
  json           = require(BASE(..., 'json')),
  with           = require(BASE(..., 'with')),
  assign         = require(BASE(..., 'assign')),
  memoize        = require(BASE(..., 'memoize')),
  growtable      = require(BASE(..., 'growtable')),
  raiseerror     = require(BASE(..., 'raiseerror')),
  defineclass    = require(BASE(..., 'defineclass')),
  parametercheck = require(BASE(..., 'parametercheck')),
}