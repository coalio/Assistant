-- example1.lua
-- Description: Creates a simple sheet

local Assistant = require('assistant') -- Import assistant.lua

local Sheet = Assistant.Sheet -- Rename sheet for cleaner code

--[[
  Create 2 sheets: Friends, Debts
  We can have duplicated friends
  We don't want duplicated debt names
  
  ]]

local Friends = {Paul = 'Good old friend', Alan = 'He allows me to copy his exam, thank you alan!'}
local SheetOne = Sheet:new {data = Friends}

local Debts = {Paul = 100, Alan = 0}
local SheetTwo = Sheet:new {data = Debts}, {properties = {
  allowDuplicates = false
  }
}

-- Print the content directly from both sheets

print('Friends: ')
for k,v in pairs(SheetOne.data) do print(k .. ': ' .. v) end
print('Can we have duplicates? > ' .. tostring(SheetOne.properties.allowDuplicates))

print('\n')

print('Debts: ')
for k,v in pairs(SheetTwo.data) do print(k .. ': ' .. '$'..v) end
print('Can we have duplicates? > ' .. tostring(SheetTwo.properties.allowDuplicates))

function printRows(m)
  print('ROW')
  for k,v in pairs(m) do 
    print(k, unpack(v))
  end
end

printRows(SheetOne.rows)

