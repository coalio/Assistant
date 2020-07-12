-- Utils

return {
  json = require(BASE(..., 'json')),
  memoize = require(BASE(..., 'memoize')),
  with = require(BASE(..., 'with')),
  defineclass = require(BASE(..., 'defineclass')),
  pointer = require(BASE(..., 'pointer'))
}