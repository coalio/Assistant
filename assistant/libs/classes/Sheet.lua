-- Sheet.lua
-- Name: Sheet
-- Type: Class
-- Description: Creates and manages a dataframe

local index = require(PATH(..., 'index'))

local get_rows = index.get_rows
local define_rows = index.define_rows
local define_columns = index.define_columns
local actions = index.actions

local define_class = utils['defineclass']
local with = utils['with']
local pointer = utils['pointer']

-- Class prototype

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
  }
}

-- Class constructor

local property_types = {
  ['data'] = {'table'},
  ['properties'] = {'table', 'named_args'},
  ['allowDuplicates'] = {'boolean'},
  ['before'] = {'function'},
  ['after'] = {'function'},
  ['case'] = {'table'},

  required = {'data'}
}

function Sheet:new(...)
  local o = {}
  if arg[1] == 'raw' then
    o = arg[2]
  else
    o = define_class(self._name, property_types, {({...})[1]} )
  end
  setmetatable(o, {__index = self['prototype'], __mode = 'k'})

  local rawrows = get_rows(o.data)
  o.rows = pointer(
    rawrows, 
    ({...})[2]['rows_index'] or define_rows(rawrows, ({...})[2]['rows']),
    with(actions)
  )

  o.row_names =({...})[2]['rows']
  o.rows_length = #o.rows

  o.columns = pointer(
    o.data, 
    ({...})[2]['columns_index'] or define_columns(o.data, ({...})[2]['columns']),
    with(actions)
  )

  o.column_names = ({...})[2]['columns']
  o.columns_length = #o.data

  collectgarbage() return o
end

return Sheet