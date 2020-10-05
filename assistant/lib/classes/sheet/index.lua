-- sheet.lua
-- Sheet functions

return {
  -- Internal
  defineRows    = require(BASE(..., 'defineRows')),
  defineColumns = require(BASE(..., 'defineColumns')),
  
  -- Public
  at            = require(PATH(CLASS_PATH .. 'public', 'at')),
  min           = require(PATH(CLASS_PATH .. 'public', 'min')),
  max           = require(PATH(CLASS_PATH .. 'public', 'max')),
  print         = require(PATH(CLASS_PATH .. 'public', 'print')),
  append        = require(PATH(CLASS_PATH .. 'public', 'append')),
  getRows       = require(PATH(CLASS_PATH .. 'public', 'getRows')),
  actions       = require(PATH(CLASS_PATH .. 'public.actions', 'index'))
}