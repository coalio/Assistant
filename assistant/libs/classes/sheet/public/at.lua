-- sheet.lua: at()
-- Allows you to get an item using column/row indices/labels
-- Example: datasheet:at('Column1', 'Row2')

return function(data, column, row)
  return data.columns[column][data.rows['_pointers'][row]]
end