-- sheet.lua
-- Parse rows from your data

return function(data)
  local rows = {}
  if #data~=0 then -- Array indices
    for index = 1, #data do
      rows[index] = {}
      for column_index, column in pairs(data) do
        if type(column) ~= 'table' then
          if index == 0 then
            if column == nil then column = 'N/A' end
            rows[index][#rows[index] + 1] = column
          end
        else
          if column[index] == nil then column[index] = 'N/A' end
          rows[index][#rows[index] + 1] = column[index]
        end
      end
    end
  else -- Hash
    for column_name, column in pairs(data) do
      if type(column) ~= 'table' then
        rows[1] = rows[1] or {}
        rows[1][#rows[1] + 1] = {}
        rows[1][#rows[1]] = column
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
  end
  return rows
end