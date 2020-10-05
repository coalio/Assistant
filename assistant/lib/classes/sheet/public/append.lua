-- sheet.lua: append()
-- Appends a column at the desired position

local checkArguments = utils.checkArguments
local raiseError = utils.raiseError
local fallbacks = utils.fallbacks
local parameterTypes = {
  'table',
  'string|number',
  'table',
  'number'
}

return function(data, column, value, position)
  parameters = {data, column, value, position}
  if checkArguments((data['_type'] or 'sheet') .. ':append', parameterTypes, parameters) == -1 then
    return
  end

  parameterFallbacks = {
    -- not position and (column number or labels size + 1) or position
    {
      'position', not position, 
      type(column)=='number' and column or #data.columns['_metadata'].labels + 1,
      position
    }
  }
  local position = fallbacks(parameterFallbacks)
  local columnPos = #data.columns + 1

  -- Check arguments
  if column == nil or (type(column) ~= 'string' and type(column) ~= 'number') then
    raiseError(2, data['_name']..':append', {column, value, position},
    'column name is not of valid type ' .. '(' .. type(column) .. ')')
    return
  end
  if data.columns[column] or data.columns['_metadata'].pointers[position] then
    raiseError(2, data['_name']..':append', {column, value, position},
      'column with name ' .. column .. ' already exists')
    return
  end
  if #data.columns['_metadata'].labels+1 < position then
    raiseError(2, data['_name']..':append', {column, value, position},
      'column position ' .. position .. ' is out of bounds (bound: ' 
      .. #data.columns['_metadata'].labels + 1 .. ')')
    return
  end
  
  -- If the data contains an array part, insert, otherwise, name
  if #data.columns~=0 then
    data.columns['_metadata'].pointers[column] = columnPos
    table.insert(data.columns, columnPos, value)
  else
    data.columns[column] = value
    data.columns['_metadata'].pointers[columnPos] = column
  end
  table.insert(data.columns['_metadata'].labels, position, column)

  -- Add to rows
  for row_index = 1, #data.columns[column] do

    -- row_name holds the label for the row at row_index (that is, its name)
    row_name = data.rows['_labels'][row_index]

    -- If the row does not yet exist:
    --  1. Create it using row_index as name
    --  2. Append it to data.rows['_labels'], so the sheet is aware of its existence
    if not row_name then
      row_name = row_index
      data.rows[row_index] = {}
      data.rows['_labels'][row_index] = row_index
    end
    row = data.rows[row_name]
    data.rows[row_name][#row+1] = data.columns[column][row_index]
  end
end