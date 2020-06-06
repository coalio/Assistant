-- Sheet.lua
-- Name: Sheet
-- Type: Class
-- Description: Creates and manages a data set
local Sheet = {
  _name = 'Sheet',

  this = {
    data = {},
    rows = {},
    rows_length = 0,
    columns = {}, -- contains names only
    columns_length = 0,
    properties = {
      allowDuplicates = true
    },

    before = nil,
    after = nil,
    case = nil,

    -- Public functions
    GetRow = function(row)
      return self.rows[row]
    end,
    Show = function(size)

    end,
  }
}

local property_types = {
  -- Types allowed for properties, similar to argcheck
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
    o = _set_class(self._name, property_types, {...})
  end
  local c = self['this']
  setmetatable(o, {__index = c, __mode = 'k'})

  -- pre-processing
  o.rows = _getrows(o.data)
  o.rows_length = #o.rows
  
  o.columns = {}
  for keyset, _ in pairs(o.data) do 
    o.columns[#o.columns + 1] = keyset
  end
  table.sort(o.columns)

  o.columns_length = #o.data
  collectgarbage() return o
end

function _getrows(columns)
  local rows = {}
  if #columns~=0 then
    for index = 1, #columns do
      rows[index] = {}
      for column_index, column in pairs(columns) do
        if type(column) ~= 'table' then
          if index == 1 then
            if column == nil then column = ' ' end
            rows[index][#rows[index] + 1] = column
          end
        else
          if column[index] == nil then column[index] = ' ' end
          rows[index][#rows[index] + 1] = column[index]
        end
      end
    end
  else
    local largest_column_size = 0
    for column_name, column in pairs(columns) do
      if type(column) ~= 'table' then break end
      if #column > largest_column_size then
        largest_column_size = #column
      end
    end
    if largest_column_size == 0 then largest_column_size = 1 end
    for row = 1, largest_column_size do
      local index = row
      rows[row] = {}
      for column_name, column in pairs(columns) do
        if type(column) ~= 'table' then
          if row == 1 then
            if column == nil then column = ' ' end
            rows[row][#rows[row] + 1] = column
          end
        else
          if column[index] == nil then column[index] = ' ' end
          rows[row][#rows[row] + 1] = column[index]
        end
      end
    end
  end
  return rows
end

return Sheet