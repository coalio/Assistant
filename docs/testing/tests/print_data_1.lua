-- sheet.print() is a very versatile function
-- Assistant has intelligent column/row naming that allows things like this example

local sheet = require('assistant').sheet

-- You can opt for doing an array or hash table (or both)
-- ['year'] = {2010, 2011, 2012, ...
-- However, the array part wont be mixed with the hash part
data = {
  { 
    2010, 2011, 2012,
    2010, 2011, 2012,
    2010, 2011, 2012
  } ,
  {
  'FCBarcelona', 'FCBarcelona',
  'FCBarcelona', 'RMadrid',
  'RMadrid', 'RMadrid',
  'ValenciaCF', 'ValenciaCF',
  'ValenciaCF'
  } ,
  ['wins'] = {30, 28, 32, 29, 32, 26, 21, 17, 19},
  ['draws'] = {6, 7, 4, 5, 4, 7, 8, 10, 8},
  ['losses'] = {2, 3, 2, 4, 2, 5, 9, 11, 11}
}

football = sheet:new(
  {data = data},
  {
    columns = { 'year', 'team', 'wins', 'draws', 'losses' }, -- Order columns like this
    rows = {'FC1', 'FC2', 'FC3', 'RM1', 'RM2', 'RM3', 'CF1', 'CF2', 'CF3'} -- Give rows a name
  }
)

--Append a new column that holds the index for every row
newRow = {
  name = 'index',
  content = {}
}
for i = 1, #football.rows do
  table.insert(newRow.content, i)
end

football:append(
  newRow.name,
  newRow.content, 1 -- Append at position 1, that is, the first column
)

-- Print the data
football(-1, -1, -1, {
  {'index', 'year', 'team', 'wins', 'draws', 'losses'} -- Print only these columns and in this order
}) -- football() is syntactic sugar for football:print()

-- You can play with this example
-- sheet size is 5x9 (6x9 after appending column)