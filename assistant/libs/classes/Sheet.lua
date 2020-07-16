-- Sheet.lua
-- Name: Assistant.Sheet
-- Type: Class
-- Description: Creates and manages a dataframe

CLASS_PATH = LIBS_PATH .. 'classes.sheet.'
local index = require(PATH(..., 'index'))

-----------------------------------------------------------------------------
-- Index sheet/* functions
-----------------------------------------------------------------------------
local get_rows = index.get_rows
local define_rows = index.define_rows
local define_columns = index.define_columns

local at = index.at
local min = index.min
local max = index.max
local actions = index.actions
local reference = index.reference

local define_class = utils['defineclass']
local with = utils['with']
local pointer = utils['pointer']


-----------------------------------------------------------------------------
-- Class prototype
-----------------------------------------------------------------------------
local Sheet = {
  _name = 'Sheet',

  prototype = {
    data = {},
    rows = {},
    rows_length = 0,
    columns = {},
    columns_length = 0,
    properties = {
      allowDuplicates = true
    },

    type = nil,
    before = nil,
    after = nil,
    case = nil
  },

  -- General

  max = max,
  min = min,
  reference = reference
}

-----------------------------------------------------------------------------
-- Property types
-----------------------------------------------------------------------------
local property_types = {
  ['data']            = {'table'},
  ['properties']      = {'table', 'named_args'},
  ['allowDuplicates'] = {'boolean'},
  ['before']          = {'function'},
  ['after']           = {'function'},
  ['case']            = {'table'},

  required = {'data'}
}

-----------------------------------------------------------------------------
-- Class constructor
-----------------------------------------------------------------------------
function Sheet:new(...)
  local newSheet = {}
  if arg[1] == 'raw' then
    newSheet = arg[2]
  else
    newSheet = define_class(self._name, property_types, {({...})[1]} )
  end
  setmetatable(newSheet, {__index = self['prototype'], __mode = 'k'})

  local rawrows = get_rows(newSheet.data)
  local row_pointers = (
    (
      ({...})[2] ~= nil and
      ({...})[2]['rows_index'] or define_rows(rawrows, ((({...})[2]~=nil and ({...})[2]) or {})['rows'])
    ) 
    or {}
  ) -- If the user provided details then define row labels using pointers
  local column_pointers = (
    (
      ({...})[2] ~= nil and
      ({...})[2]['columns_index'] or define_columns(newSheet.data, ((({...})[2]~=nil and ({...})[2]) or {})['columns'])
    ) 
    or {}
  ) -- If the user provided details then define column labels using pointers
  newSheet.rows = pointer(
    rawrows,
    row_pointers, -- Contains an empty table or pointers
    with(actions)
  )
  newSheet.row_names = ((({...})[2]~=nil and ({...})[2]) or {})['rows']
  newSheet.rows_length = #newSheet.rows
  newSheet.columns = pointer(
    newSheet.data, 
    column_pointers, -- Contains an empty table or pointers
    with(actions)
  )
  newSheet.column_names = ((({...})[2]~=nil and ({...})[2]) or {})['columns']
  newSheet.columns_length = #newSheet.data

  -- Functions

  newSheet.at = at 
  newSheet.getRows = get_rows 
  collectgarbage() return newSheet
end

return Sheet