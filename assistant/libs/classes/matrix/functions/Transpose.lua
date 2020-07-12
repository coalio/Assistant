-- matrix.lua
-- Flips a matrix over its diagonal, that is, it switches the column and row indexes of the matrix

return function(self)
  local data = self.data
  if data == nil or next(data) == nil then error("data can't be nil or empty") end
  local columns = {}
  for index = 1, #data do 
    columns[index] = {}
    for row_index, row in pairs(data) do
      if row[index] == nil then error("data can't have nil values") end
      columns[index][#columns[index] + 1] = row[index]
    end
  end
  return columns
end