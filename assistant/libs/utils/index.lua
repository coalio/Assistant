-----------------------------------------------------------------------------
-- Collection of utilities used internally
-----------------------------------------------------------------------------

return {
  growtable   = require(BASE(..., 'growtable')),
  json        = require(BASE(..., 'json')),
  with        = require(BASE(..., 'with')),
  pointer     = require(BASE(..., 'pointer')),
  memoize     = require(BASE(..., 'memoize')),
  defineclass = require(BASE(..., 'defineclass'))
}