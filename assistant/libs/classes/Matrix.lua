-- Matrix.lua
-- Name: Matrix
-- Type: Class
-- Description: Creates and allows simple (non-optimized!) operations over a Matrix

local index = require(PATH(..., 'index'))
local functions = require(PATH(..., 'functions'))

local get_rows = index.get_rows
local define_rows = index.define_rows
local define_columns = index.define_columns

local define_class = utils['defineclass']
local with = utils['with']
local pointer = utils['pointer']

-- Class prototype

local Matrix = {
  _name = 'Matrix',

  prototype = {
    data = {},
    rows = {},
    rows_length = 0,
    columns = {},
    columns_length = 0,
  }
}

-- Class constructor

local property_types = {
  ['data'] = {'table'},

  required = {'data'}
}

function Matrix:new(...)
  local o = {}
  if arg[1] == 'raw' then
    o = arg[2]
  else
    o = define_class(self._name, property_types, {...})
  end
  setmetatable(o, {__index = self['prototype'], __mode = 'k'})

  local rawrows = get_rows(o.data)
  o.rows = pointer(
    rawrows, 
    select(1, {...})[rows_index] or define_rows(rawrows, select(1, {...})[rows]),
    with(actions)
  )

  o.row_names = select(1, {...})[rows]
  o.rows_length = #o.rows

  o.columns = pointer(
    o.data, 
    select(1, {...})[columns_index] or define_columns(o.data, select(1, {...})[columns]),
    with(actions)
  )
  
  o.column_names = select(1, {...})[columns]
  o.columns_length = #o.data

  collectgarbage() return with(o, functions)
end

return Matrix