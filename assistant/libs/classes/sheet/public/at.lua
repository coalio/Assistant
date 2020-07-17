-- sheet.lua: at()
-- Allows you to get an item using column/row indices/labels
-- Example: datasheet:at('Column1', 'Row2')

return function(data, column, row)
  if tonumber(column) then column = tonumber(column) end
  if tonumber(row) then row = tonumber(row) end
  column = (((data.columns[column] and column) or data.columns['_pointers'][column]) or column)
  row = (((data.columns[column][row] and row) or data.rows['_pointers'][row]) or row)
  assert(data.columns[column], 
  'At ('..column..', '..row..'):\nA column called ' .. column .. ' does not exist')
  assert(data.columns[column][row], 
  'At ('..column..', '..row..'):\nA row called ' .. row .. ' at column ' .. column .. ' does not exist')
  return data.columns[column][row]
end