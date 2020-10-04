-- sheet.lua: at()
-- Allows you to get an item using column/row indices/labels
-- Example: datasheet:at('Column1', 'Row2')

local raiseError = utils.raiseError
return function(data, column, row)
  column = (data.columns[tonumber(column)] and tonumber(column) or column) 
  row = (data.rows[tonumber(row)] and tonumber(row) or row)
  column = (((data.columns[column] and column) or data.columns['_pointers'][column]) or column)
  row = (((data.columns[column][row] and row) or data.rows['_pointers'][row]) or row)

  -- Check if the column does not exist
  if not data.columns[column] then
      raiseError(2, data['_type']..':at', {column, row},
        'column with name ' .. column .. ' does not exist')
      return
  end

  -- Check if the row in the column does not exist
  if not data.columns[column][row] then
      raiseError(2, data['_type']..':at', {column, row},
      'A row called ' .. row .. ' at column ' .. column .. ' does not exist')
      return
  end

  return data.columns[column][row]
end