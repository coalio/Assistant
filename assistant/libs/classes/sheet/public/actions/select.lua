-- sheet.lua: select()
-- Selects specific series

local pointer = utils['pointer']
local with = utils['pointer']
return function(data, ...)
  if #{...} == 1 then 
    local p = {...} 
    return (
      (
        type(data[p[1]]) == 'table' and pointer(data[p[1]], {}, with(data['_prototype']))
      )
      or data[p[1]]
    )
  end

  local subsets = {}
  for _, name in pairs({...}) do
    subsets[name] = data[name]
  end
  return pointer(subsets, {}, with(data['_prototype']))
end