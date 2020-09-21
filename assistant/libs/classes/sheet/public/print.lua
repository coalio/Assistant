-- sheet.lua: print()
-- Prints the values within a dataframe/series in order
-- Specify labels to display, will default to _labels otherwise

local raiseError = utils.raiseError
return function(data, maxColumns, maxRows, maxCellsize, labels)
    -- Transform arguments
    local labels = labels or {}
    local columnLabels = ((next((labels)[1] or {})~=nil and (labels)[1]) or data.columns['_labels'])
    local rowLabels = ((next((labels)[2] or {})~=nil and (labels)[2]) or data.rows['_labels'])

    -- If nil, then set default, else if -1 or negative, set max
    maxCellsize = maxCellsize or 15
    maxCellsize = ((maxCellsize < 0 and -1) or maxCellsize)
    maxColumns = maxColumns or ((10 > #columnLabels and #columnLabels) or 10)
    maxRows = maxRows or ((10 > #rowLabels and #rowLabels) or 10)
    maxColumns = ((maxColumns < 0 and math.huge) or maxColumns)
    maxRows = ((maxRows < 0 and math.huge) or maxRows)
    maxColumns = ((maxColumns > #columnLabels and #columnLabels) or maxColumns)
    maxRows = ((maxRows > #rowLabels and #rowLabels) or maxRows)

    -- Transform row and column labels to strings/numbers respectively
    for i, label in pairs(columnLabels) do
      columnLabels[i] = ((tonumber(label)==nil and tostring(label)) or tonumber(label))
    end
    for i, label in pairs(rowLabels) do
      rowLabels[i] = ((tonumber(label)==nil and tostring(label)) or tonumber(label))
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

    -- Transform column labels 
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
      'Displaying '..
      ((maxCellsize == -1 and 'all') or 'up to '..maxCellsize)..
      ' characters for '..
      ((maxColumns == math.huge and #columnLabels) or maxColumns)..
      ' columns and '..
      ((maxRows == math.huge and #rowLabels) or maxRows)..' rows\n'
    )

    -- Print column labels
    print(
      ('#' .. (' '):rep(
        ((cellSizes.rowLabels>1 and cellSizes.rowLabels) or 0)
      )):sub(1, maxCellsize), 
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
          (
            column[data.rows['_pointers'][rowLabels[#rows]]] 
            and column[data.rows['_pointers'][rowLabels[#rows]]]
          )
          or (
            (
              column[rowLabels[#rows]] and column[rowLabels[#rows]]
            )
            or column[tostring(rowLabels[#rows])]
          )
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