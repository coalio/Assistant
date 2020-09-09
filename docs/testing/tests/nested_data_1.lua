local assistant = require('assistant')
local myData = {
  { -- Column 1 "Customer1"
    'Alex', -- Row 1 "customer_name"
    { -- Row 2 "purchases"
      [1] = 'Wuu I',
      [2] = 'Polynomialstation',
      [3] = 'Coal'
    }
  },
  { -- Column 2 "Customer2"
    'Maximilian', -- Row 1 "customer_name"
    { -- Row 2 "purchases"
      [1] = 'Wii U',
      [2] = 'Playstation 5',
      [3] = 'Carbon'
    }
  }
}

customersSheet = assistant.Sheet:new ({data = myData}, 
  {
    columns = {'Customer1', 'Customer2'}, -- Assign the column labels in order of declaration
    rows = {'customer_name', 'purchases'} -- Assign the row names in order of declaration
  }
)

-- Display the name of Customer1
print('Using indices:', customersSheet['1:1'])
print('Using labels:', customersSheet['Customer1:customer_name'])
print('Using labels (Mixed):', customersSheet['1:customer_name'])
print('Pure indexing columns:', customersSheet.columns[1][1], '\n')

-- Display purchases of Customer2
print('Purchases of ', customersSheet['1:1'])
for index, value in pairs(customersSheet['1:purchases']) do
  print('Item ' .. index, 'Name: ' .. value)
end