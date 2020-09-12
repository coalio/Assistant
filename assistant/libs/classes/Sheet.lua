-- Sheet.lua
-- Name: Assistant.Sheet
-- Type: Class
-- Description: Creates and manages a dataframe

CLASS_PATH = LIBS_PATH .. 'classes.sheet.'
local index = require(PATH(..., 'index'))

-----------------------------------------------------------------------------
-- Index sheet/* functions
-----------------------------------------------------------------------------
local define_rows = index.define_rows
local define_columns = index.define_columns

local at = index.at
local min = index.min
local max = index.max
local print = index.print
local append = index.append
local actions = index.actions
local get_rows = index.get_rows

local define_class = utils['defineclass']
local with = utils['with']
local assign = utils['assign']

-----------------------------------------------------------------------------
-- Class prototype
-----------------------------------------------------------------------------
local Sheet = {
  metadata = {
    ['type'] = 'sheet',
    ['name'] = 'sheet'
  },

  prototype = {
    data = {},
    rows = {},
    columns = {},
    properties = {
      allowDuplicates = false
    },

    before = nil,
    after = nil,
    case = nil,

    at = at,
    print = print,
    append = append
  },

  -- General

  max = max,
  min = min,
  print = print,
  getRows = get_rows
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
  local prototype = self['prototype']
  if ({...})[1] == 'raw' then
    newSheet = arg[2]
  else
    newSheet = define_class(self.metadata.type, property_types, {({...})[1]} )
  end
  local parameters = ((({...})[2]~=nil and ({...})[2]) or {})
  local rawrows = get_rows(newSheet.data)
  local row_pointers = (
    (
      ({...})[2] ~= nil and
      ({...})[2]['rows_index'] or
      define_rows(rawrows, parameters['rows'],
      parameters['row_prefix'] or '',
      parameters['row_suffix'] or '')
    ) 
    or {}
  ) -- If the user provided metadata then define row labels using pointers, otherwise sort

  local column_pointers = (
    (
      ({...})[2] ~= nil and
      ({...})[2]['columns_index'] or 
      define_columns(newSheet.data, parameters['columns'],
      parameters['column_prefix'] or '',
      parameters['column_suffix'] or '')
    )
    or {}
  ) -- If the user provided metadata then define column labels using pointers, otherwise sort

  -- Define child object
  newSheet.metadata = self.metadata
  newSheet.row_names = parameters['rows'] or {}
  newSheet.column_names = parameters['columns'] or {}

  -- assign() allows us to, well, assign, different labels and functions to the object
  newSheet.rows = assign(
    'series',
    newSheet.row_names,
    rawrows,
    row_pointers, -- Contains an empty table or pointers
    with(actions)
  )

  newSheet.columns = assign(
    'series',
    newSheet.column_names,
    newSheet.data, 
    column_pointers, -- Contains an empty table or pointers
    with(actions)
  )
  
  -- Functions
  newSheet.at = at
  newSheet.print = print
  newSheet.append = append

  -- Build class object
  setmetatable(newSheet, {
    __index = function(self, index)
      if prototype[index] then return rawget(prototype, index) end

      -- Syntactic sugar for at() function (sheet['column:row'])
      if type(index) == 'string' then
        if (index:match("^(.+):(.+)")) then
          local column_name = index:gsub(":.*", "")
          local row_name = index:gsub("[^:]+:", "")
          return self:at(column_name, row_name)
        end  
      end

      if tostring(index):sub(1,1) == '_' then
        local mdname = tostring(index):sub(2,#index)
        return self.metadata[mdname]
      end
    end,

    __newindex = function(self, index, value)
      if tostring(index):sub(1,1) == '_' then
        mdname = tostring(index):sub(2,#index)
        rawset(self.metadata, mdname, value)
        return
      end

      rawset(self, index, value)
    end,

    __call = function(self, ...)
      self:print(unpack({...}))
    end
  })

  return newSheet
end

return Sheet