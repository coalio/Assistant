-- sheet.lua
-- Name: Assistant.sheet
-- Type: Class
-- Description: Creates and manages a dataframe

CLASS_PATH = LIBS_PATH .. 'classes.sheet.'
local index = require(PATH(..., 'index'))

-----------------------------------------------------------------------------
-- Index sheet/* functions
-----------------------------------------------------------------------------
local defineRows = index.defineRows
local defineColumns = index.defineColumns

local at = index.at
local min = index.min
local max = index.max
local print = index.print
local append = index.append
local actions = index.actions
local getRows = index.getRows

local defineClass = utils.defineClass
local with = utils.with
local assign = utils.assign

-----------------------------------------------------------------------------
-- Class prototype
-----------------------------------------------------------------------------
local sheet = {
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
  getRows = getRows
}

-----------------------------------------------------------------------------
-- Property types
-----------------------------------------------------------------------------
local propertyTypes = {
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
function sheet:new(...)
  local newSheet = {}
  local prototype = self['prototype']
  if ({...})[1] == 'raw' then
    newSheet = arg[2]
  else
    newSheet = defineClass(self.metadata.type, propertyTypes, {({...})[1]} )
  end
  local arguments = ((({...})[2]~=nil and ({...})[2]) or {})
  local rawRows = getRows(newSheet.data)
  local rowPointers = (
    (
      ({...})[2] ~= nil and
      ({...})[2]['rowsIndex'] or
      defineRows(
        rawRows, arguments['rows'],
        arguments['rowPrefix'] or '',
        arguments['rowSuffix'] or ''
      )
    ) 
    or {}
  ) -- If the user provided metadata then define row labels using pointers, otherwise sort

  local columnPointers = (
    (
      ({...})[2] ~= nil and
      ({...})[2]['columnsIndex'] or 
      defineColumns(
        newSheet.data, arguments['columns'],
        arguments['columnPrefix'] or '',
        arguments['columnSuffix'] or ''
      )
    )
    or {}
  ) -- If the user provided metadata then define column labels using pointers, otherwise sort

  -- Define child object
  newSheet.metadata = self.metadata
  newSheet.rowNames = arguments['rows'] or {}
  newSheet.columnNames = arguments['columns'] or {}

  -- assign() allows us to, well, assign, different labels and functions to the object
  newSheet.rows = assign(
    'series',
    newSheet.rowNames,
    rawRows,
    rowPointers, -- Contains an empty table or pointers
    with(actions)
  )

  newSheet.columns = assign(
    'series',
    newSheet.columnNames,
    newSheet.data, 
    columnPointers, -- Contains an empty table or pointers
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
          local columnName = index:gsub(":.*", "")
          local rowName = index:gsub("[^:]+:", "")
          return self:at(columnName, rowName)
        end  
      end

      if tostring(index):sub(1,1) == '_' then
        local metadataIndex = tostring(index):sub(2,#index)
        return self.metadata[metadataIndex]
      end
    end,

    __newindex = function(self, index, value)
      if tostring(index):sub(1,1) == '_' then
        metadataIndex = tostring(index):sub(2,#index)
        rawset(self.metadata, metadataIndex, value)
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

return sheet