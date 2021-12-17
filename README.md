<div align="center">
  <img id="thumbnail" src="https://github.com/coalio/Assistant/blob/master/docs/repo/assistant-brand-l.png?raw=true" thumbnail>
</div>

-----------------

[![Last Commit](https://img.shields.io/github/last-commit/coalio/assistant)](https://github.com/coalio/Assistant/commits/master)
[![Only Lua](https://img.shields.io/badge/lua-100%25-blue)](https://github.com/coalio/Assistant/search?l=lua)

## What is Assistant?

Assistant is a data science library for Lua 5.1+

Assistant aspires to provide the tools required for real-world data management,
because Lua also deserves a nice data science and data analysis library.

*I'm currently the only maintainer of this project*, but I would love your contributions
and I'm currently looking for help.

## Currently implemented

1. Label naming, be it strings, numbers, or a combination of both
2. Column sorting by labels
3. Printing your dataframe in the form of a spreadsheet within your console
4. Smart indexing functions
5. Metamethods to make the code as simple as possible

## What Assistant should support next

1. Data analysis functions
2. Plotting and visualization
3. Memoize for faster indexing
4. Importing and exporting data to different file formats
5. Integration with Torch and Torchnet for machine learning

## Contributions

I would love if you contributed to Assistant, and I wouldn't like to un-inspire you from contributing,
but to make the code easier to maintain in the long term, there's a <a href="https://github.com/coalio/Assistant/blob/master/conventions.txt">conventions.txt</a> file
  
These conventions are not very restricting, as long as it works there's no need to use a special method for it

```lua
-- sheet.print() is a very versatile function
-- Assistant has intelligent column/row naming that allows things like this example

local sheet = require('assistant').sheet

-- You can opt for using an array or hash table (or both)
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
    rows = {'FC1', 'FC2', 'FC3', 'RM1', 'RM2', 'RM3', 'CF1', 'CF2', 'CF3'} -- Give rows a label
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
```

```lua
Displaying all characters for 6 columns and 9 rows

#       index   year    team            wins    draws   losses
FC1     1       2010    FCBarcelona     30      6       2
FC2     2       2011    FCBarcelona     28      7       3
FC3     3       2012    FCBarcelona     32      4       2
RM1     4       2010    RMadrid         29      5       4
RM2     5       2011    RMadrid         32      4       2
RM3     6       2012    RMadrid         26      7       5
CF1     7       2010    ValenciaCF      21      8       9
CF2     8       2011    ValenciaCF      17      10      11
CF3     9       2012    ValenciaCF      19      8       11
Sheet size:     6x9     (col x row)
```
