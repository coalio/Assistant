local Sheet = require('assistant').Sheet
local json = require('json')


-- We want to load the dataset and extract the relevant data
local dataset = json.parse(io.open('large_data_1_dataset.json', 'r'):read('*a'))
datasheet = Sheet:new {data = dataset}

-- Print information about the dataset
-- This information is stored at datasetid
print('Datased ID: ' .. datasheet.rows:select('datasetid')[1])
-- The structure of this dataset makes "fields" a table row containing individual information of passengers

-- Name and age

local name_age = (
  Sheet:new { data=datasheet.rows['fields'] }
  ['rows']:select('name', 'age')
)

-- Minimum ages
maximum = Sheet.max(name_age['age'],5)
minimum = Sheet.min(name_age['age'],5)

-- Print oldest ages
print('Oldest:')
for n, value in ipairs(maximum) do
  print(n, value)
end

-- Print youngest ages
print('Youngest:')
for n, value in ipairs(minimum) do
  print(n, value)
end

datasheet = Sheet:new (
  {data = datasheet.rows['fields']}
)

-- Print up to 5 columns and all available rows from datasheet
datasheet:print(5,-1)