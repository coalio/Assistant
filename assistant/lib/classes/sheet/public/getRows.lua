-- sheet.lua: get_rows(), getRows()
-- Parses rows by their labels/index and returns the resulting series

local checkArguments = utils.checkArguments
local parameterTypes = {
  'table'
}

return function(data)
  parameters = {data}
  if checkArguments((data['_type'] or 'sheet') .. ':getRows', parameterTypes, parameters) == -1 then
    return
  end

  local rows = {}
  for column_name, column in pairs(data) do
    if type(column) ~= 'table' then
      rows[1] = rows[1] or {}
      rows[1][#rows[1] + 1] = {}
      table.insert(rows[1][#rows[1]], column)
    else
      local column_index = 1
      for column_item_name, column_item in pairs(column) do
        rows[column_item_name] = rows[column_item_name] or {}
        rows[column_item_name][#rows[column_item_name] + 1] = {}
        rows[column_item_name][#rows[column_item_name]] = column_item
        column_index = column_index + 1
      end
    end
  end
  return rows
end