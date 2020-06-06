-- yeah, no, not your complete matrix library, just enough to perform
-- operations within your damn sheets

local matrix = {}

function matrix:Transpose(matrix)
  if matrix == nil or next(matrix) == nil then error("Matrix.Transpose matrix can't be nil or empty") end
  local columns = {}
  for index = 1, #matrix do 
    columns[index] = {}
    for row_index, row in pairs(matrix) do
      if row[index] == nil then error("Matrix.Transpose matrix can't have nil values") end
      columns[index][#columns[index] + 1] = row[index]
    end
  end
  return columns
end

return matrix