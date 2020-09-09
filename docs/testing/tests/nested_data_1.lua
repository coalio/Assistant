local assistant = require('assistant')
local myData = {
  ['Customer1'] = {
    customer_name = 'Alex',
    purchases = {
      [1] = 'Wuu I',
      [2] = 'Polynomialstation',
      [3] = 'Coal'
    }
  },
  ['Customer2'] = {
    customer_name = 'Maximilian',
    purchases = {
      [1] = 'Wii U',
      [2] = 'Playstation 5',
      [3] = 'Carbon'
    }
  }
}

customersSheet = assistant.Sheet:new {data = myData}

print(customersSheet['Customer2:customer_name'] .. ' purchased the following items:')
for purchase_id, purchase_name in pairs(customersSheet['Customer2:purchases']) do
  print(purchase_id, purchase_name)
end