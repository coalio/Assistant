-- sheet.lua: print()
-- Prints the values within a dataframe/series in order
-- Specify labels to display, will default to _labels otherwise

local checkArguments = utils.checkArguments
local raiseError = utils.raiseError
local fallbacks = utils.fallbacks
local parameterTypes = {
  'table',
  'number',
  'number',
  'number',
  'table'
}

return function(data, maxColumns, maxRows, maxCellsize, labels)
  parameters = {
    data, maxColumns, 
    maxRows, maxCellsize, 
    labels
  }

  if checkArguments((data['_type'] or 'sheet') .. ':print', parameterTypes, parameters) == -1 then 
    return
  end

  local labels = labels or {}
  local columnLabels = next((labels or {})[1] or {}) ~= nil and labels[1] or data.columns['_labels']
  local rowLabels = next((labels or {})[2] or {}) and labels[2] or data.rows['_labels']

  -- Fallbacks
  parameterFallbacks = {
    -- not maxCellsize and 15 or maxCellsize
    {'maxCellsize', not maxCellsize, 15, maxCellsize},
    -- not maxColumns and (10 > #columnLabels and #columnLabels or 10) or maxColumns
    {'maxColumns', not maxColumns, 10 > #columnLabels and #columnLabels or 10, maxColumns},
    -- not MaxRows and (10 > #rowLabels and #rowLabels or 10) or maxRows
    {'maxRows', not maxRows, 10 > #rowLabels and #rowLabels or 10, maxRows},
  }

  local maxCellsize, maxColumns, maxRows = fallbacks(parameterFallbacks)
  maxCellsize = maxCellsize < 0 and -1 or maxCellsize
  maxColumns = maxColumns < 0 and #columnLabels or maxColumns
  maxRows = maxRows < 0 and #rowLabels or maxRows

  -- Convert row and column labels to strings/numbers respectively
  for i, label in pairs(columnLabels) do
    columnLabels[i] = tonumber(label) or tostring(label)
  end

  for i, label in pairs(rowLabels) do
    rowLabels[i] = tonumber(label) or tostring(label)
  end

  -- Cellsize: horizontal length of a string that is used to grow shorter strings to this size
  local cellSizes = {
    ['columnLabels'] = {}, -- Holds the largest size for every column label
    ['rowLabels'] = 0 -- Rows are displayed vertically, only one horizontal length is required
  }

  -- Get the largest cellsize for every column
  for i = 1, #columnLabels do
    if i > maxColumns then break end
    if not columnLabels[i] then break end
    cellSizes.columnLabels[i] = cellSizes.columnLabels[i] or tostring(columnLabels[i]):len()
    for _, string in pairs(data.columns[columnLabels[i]]) do
      if (cellSizes.columnLabels[i] or 0) < tostring(string):len() then
          cellSizes.columnLabels[i] = tostring(string):len()
      end
    end
  end

  -- Resize column labels (add empty spaces so they fit the cell size)
  local columnHeader = {}
  for index, label in pairs(columnLabels) do
    if index > maxColumns then break end
    if tostring(label):len() < cellSizes.columnLabels[index] then
      columnHeader[index] = (
        label .. (' '):rep(
          cellSizes.columnLabels[index] - tostring(label):len()
        )
      ):sub(1, maxCellsize)
    else
      columnHeader[index] = columnLabels[index]
    end
  end

  -- Do the same with row labels
  for i, string in pairs(rowLabels) do
    if i > maxRows then break end
    if cellSizes.rowLabels < tostring(string):len() then
      cellSizes.rowLabels = tostring(string):len()
    end
  end

  -- Print "Displaying x characters for x columns and x rows"
  print(
    'Displaying ' ..
    (maxCellsize == -1 and 'all' or 'up to '.. maxCellsize) ..
    ' characters for ' ..
    maxColumns ..
    ' columns and ' ..
    maxRows .. 
    ' rows\n'
  )

  -- Print column labels
  print(
    ('#' .. (' '):rep(cellSizes.rowLabels)):sub(1, maxCellsize), 
    unpack(columnHeader)
  )

  -- Order rows
  local rows = {}
  for rowIndex, __ in pairs(rowLabels) do
    if rowIndex > maxRows then break end
    rows[#rows+1] = {}
    for i = 1, #columnLabels do
      if i > maxColumns then break end
      local column = data.columns[columnLabels[i]]

      --[[
        1. Check if the label is a number and if the item key is also a number
        2. Check if the label is a number but the item key is a string as a number
        3. Check if there is a pointer for that label
      ]]
      local item = tostring(
          column[data.rows['_pointers'][rowLabels[#rows]]] or
          column[rowLabels[#rows]] or 
          column[tostring(rowLabels[#rows])]
      )
      
      -- Adjust items to be equal in size to their respective column label cellsize
      if item:len() < cellSizes.columnLabels[i] then
        item = (
          item:sub(1, maxCellsize) .. 
          (' '):rep(
            cellSizes.columnLabels[i] - item:len()
          )
        ):sub(1, maxCellsize)
      end
      rows[#rows][#rows[#rows]+1] = item
    end
  end

  -- Print rows
  for i, row in pairs(rows) do
    for i, rowItem in pairs(row) do

      -- Fill the missing space in row label
      row[i] = tostring(rowItem):sub(1, maxCellsize)
    end
    if tostring(rowLabels[i]):len() < cellSizes.rowLabels then
      rowLabels[i] = (rowLabels[i] .. (' '):rep(cellSizes.rowLabels - tostring(rowLabels[i]):len()))
    end

    -- Print the row
    print(tostring(rowLabels[i]):sub(1, maxCellsize), unpack(row))
  end

  -- Information about the actual size of sheet
  print('Sheet size: ', #data.columns['_labels']..'x'..#data.rows['_labels'], '(col x row)')
end

-- Expected layout:

-- #        <label> <label.....> <label> <...>  <--- Column labels (. = ' ')
-- <row>    <item1> <item2large> <item3> <...>
-- <row>    <item1> <item2large> <item3> <...>
-- <row>    <item1> <item2large> <item3> <...>
-- <large>  <item1> <item2large> <item3> <...>
-- <row>    <item1> <item2large> <item3> <...>