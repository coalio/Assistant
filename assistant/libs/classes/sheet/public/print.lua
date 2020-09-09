-- sheet.lua: print()
-- Prints the values within a dataframe/series in order
-- Specify labels to display, will default to _labels otherwise

local raiseError = utils['raiseError']
return function(data, max_columns, max_rows, max_cellsize, labels)
  if data['_type'] == 'sheet' then

    -- Transform arguments
    local labels = labels or {}
    local column_labels = ((next((labels)[1] or {})~=nil and (labels)[1]) or data.columns['_labels'])
    local row_labels = ((next((labels)[2] or {})~=nil and (labels)[2]) or data.rows['_labels'])

    -- If nil, then set default, else if -1 or negative, set max
    max_cellsize = max_cellsize or 15
    max_cellsize = ((max_cellsize<0 and math.huge) or max_cellsize)
    max_columns = max_columns or ((10>#column_labels and #column_labels) or 10)
    max_rows = max_rows or ((10>#row_labels and #row_labels) or 10)
    max_columns = ((max_columns<0 and math.huge) or max_columns)
    max_rows = ((max_rows<0 and math.huge) or max_rows)
    max_columns = ((max_columns>#column_labels and #column_labels) or max_columns)
    max_rows = ((max_rows>#row_labels and #row_labels) or max_rows)

    -- Transform row and column labels to strings/numbers respectively
    local array_labels = {}
    for i, label in pairs(column_labels) do
      column_labels[i] = ((tonumber(label)==nil and tostring(label)) or tonumber(label))
    end
    for i, label in pairs(row_labels) do
      row_labels[i] = ((tonumber(label)==nil and tostring(label)) or tonumber(label))
    end

    -- Cellsize: horizontal length of a string that is used to grow shorter strings to this size
    local cellsizes = {
      ['column_labels'] = {}, -- Holds the largest size for every column label
      ['row_labels'] = 0 -- Rows are displayed vertically, only one horizontal length is required
    }

    -- Get the largest cellsize for every column
    for i = 1, #column_labels do
      if i>max_columns then break end
      if not column_labels[i] then break end
      cellsizes.column_labels[i] = cellsizes.column_labels[i] or tostring(column_labels[i]):len()
      for _, string in pairs(data.columns[column_labels[i]]) do
        if (cellsizes.column_labels[i] or 0) < tostring(string):len() then
            cellsizes.column_labels[i] = tostring(string):len()
        end
      end
    end

    -- Transform column labels 
    local column_header = {}
    for index, label in pairs(column_labels) do
      if index>max_columns then break end
      if tostring(label):len() < cellsizes.column_labels[index] then
        column_header[index] = (label .. (' '):rep(
          cellsizes.column_labels[index] - tostring(label):len())):sub(1,((max_cellsize==math.huge and -1) or max_cellsize)
        )
      else
        column_header[index] = column_labels[index]
      end
    end

    -- Do the same with row labels
    for i, string in pairs(row_labels) do
      if i>max_rows then break end
      if cellsizes.row_labels < tostring(string):len() then
        cellsizes.row_labels = tostring(string):len()
      end
    end

    -- Print labels
    print('Displaying '..((max_cellsize == math.huge and 'all') or 'up to '..max_cellsize)..' characters for '..
    ((max_columns==math.huge and #column_labels) or max_columns)..' columns and '
    ..((max_rows==math.huge and #row_labels) or max_rows)..' rows\n')
    print(('#' .. (' '):rep(
      ((cellsizes.row_labels>1 and cellsizes.row_labels) or 0))):sub(1,((max_cellsize==math.huge and -1) or max_cellsize)
    ), unpack(column_header))

    -- Order rows
    local rows = {}
    for row_index, row_name in pairs(row_labels) do
      if row_index>max_rows then break end
      rows[#rows+1] = {}
      for i = 1, #column_labels do
        if i>max_columns then break end
        local column = data.columns[column_labels[i]]
        local item = tostring(
          (
            column[data.rows['_pointers'][row_labels[#rows]]] 
            and column[data.rows['_pointers'][row_labels[#rows]]]
          )
          or (
            (
              column[row_labels[#rows]] and column[row_labels[#rows]]
            )
            or column[tostring(row_labels[#rows])]
          )
        )
        
        -- Adjust items to be equal in size to their respective column label cellsize
        if item:len() < cellsizes.column_labels[i] then
          item = (item:sub(
            1,((max_cellsize==math.huge and -1) or max_cellsize)) .. 
            (' '):rep(cellsizes.column_labels[i] - item:len())):sub(1,((max_cellsize==math.huge and -1) or max_cellsize)
          )
        end
        rows[#rows][#rows[#rows]+1] = item
      end
    end

    -- Print rows
    for i, row in pairs(rows) do
      for i, row_item in pairs(row) do

        -- Fill the missing space in row label
        row[i] = tostring(row_item):sub(1,((max_cellsize==math.huge and -1) or max_cellsize))
      end
      if tostring(row_labels[i]):len() < cellsizes.row_labels then
        row_labels[i] = (row_labels[i] .. (' '):rep(cellsizes.row_labels - tostring(row_labels[i]):len()))
      end

      -- Print the row
      print(tostring(row_labels[i]):sub(1,((max_cellsize==math.huge and -1) or max_cellsize)), unpack(row))
    end

    -- Information about the actual size of sheet
    print('Sheet size: ', #data.columns['_labels']..'x'..#data.rows['_labels'], '(col x row)')
  else
    raiseError(2, '?:print', {data, max_columns, max_rows, max_cellsize, labels},
        'data type is unsupported or could not identify the type')
  end
end

-- Expected layout:

-- #        <label> <label.....> <label> <...>  <--- Column labels (. = ' ')
-- <row>    <item1> <item2large> <item3> <...>
-- <row>    <item1> <item2large> <item3> <...>
-- <row>    <item1> <item2large> <item3> <...>
-- <large>  <item1> <item2large> <item3> <...>
-- <row>    <item1> <item2large> <item3> <...>