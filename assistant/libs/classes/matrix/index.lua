-- matrix.lua
-- Functions required by matrix

return {
  get_rows = require(BASE(..., 'get_rows')),
  define_rows = require(BASE(..., 'define_rows')),
  define_columns = require(BASE(..., 'define_rows'))
}