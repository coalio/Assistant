-- matrix.lua
-- Parses

return function(data)
  local rows = {}
  if #data~=0 then -- Array indices
    for index = 0, #data do
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
  end
  return rows
end