-- Pre-processed rows

local Assistant = require('assistant')

  --[[
  COLUMN     1     2     3     4
  ROW   
    1        1     1     1     1
    2        2     3     2     3
    3        3     4     3     4
    4        5     4     5     4
  ]]
local Matrix = { -- Declare columns horizontally
  {1, 2, 3, 5},
  {1, 3, 4, 4},
  {1, 2, 3, 5},
  {1, 3, 4, 4}
} 
-- 'If your matrix has numeric keys, DONT DO THIS'
--[[

  ['1'] = {1, 2, 3, 5},
  ['2'] = {1, 3, 4, 4},
  ['3'] = {1, 2, 3, 5},
  ['4'] = {1, 3, 4, 4}

]]
-- 'That involves WAY MORE steps to index and sort when turned to a sheet, therefore taking unecessary time'

local MatrixCol = {
{1, 1, 1, 1},
{2, 3, 2, 3},
{3, 4, 3, 4},
{5, 4, 5, 4}
} --> Declare columns vertically then transpose
local MatrixCol = Assistant.Matrix:Transpose(MatrixCol) 
-- 'Matrix.Transpose' flips a matrix over its diagonal
--  that is, it switches the row and column indices of the matrix'
-- 'Matrix.Transpose ONLY WORKS with numeric keys, ['1'] or ['Paul'] will definitely not work
-- 'If you require transposing a table with named keys (like a dictionary), use MySheet:Transpose() 
--  after turning your data into a sheet'

--  Please read assistant.lua documentation for further help

print('MatrixCol: Declared rows then transposed to form columns')
for index, element in pairs(MatrixCol) do 
  print('COLUMN', index, unpack(element))
end
print('\n')

local MyMatrixSheet = Assistant.Sheet:new {data = Matrix }, 
{ 
    properties = { 
      allowDuplicates = true 
    } 
} -- There's a lot of ways to declare a new class

function printMatrix(m)
  print('COLUMN', unpack(columns))
  print('ROW')
  for k,v in pairs(m.rows) do 
    print(k, unpack(v))
  end
end

print('MyMatrixSheet: Declared columns')
printMatrix(MyMatrixSheet)