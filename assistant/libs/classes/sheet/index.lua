-- sheet.lua
-- Sheet functions

return {
  -- Internal
  define_rows    = require(BASE(..., 'define_rows')),
  define_columns = require(BASE(..., 'define_columns')),
  -- Public
  at             = require(PATH(CLASS_PATH .. 'public', 'at')),
  min            = require(PATH(CLASS_PATH .. 'public', 'min')),
  max            = require(PATH(CLASS_PATH .. 'public', 'max')),
  get_rows       = require(PATH(CLASS_PATH .. 'public', 'get_rows')),
  reference      = require(PATH(CLASS_PATH .. 'public', 'reference')),
  actions        = require(PATH(CLASS_PATH .. 'public.actions', 'index'))
}