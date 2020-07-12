-- sheet.lua
-- Selects specific series

return function(data, ...)
  if #{...} == 1 then local p = {...} return data[p[1]] end
  local subsets = {}
  for _, name in pairs({...}) do
    subsets[name] = data[name]
  end
  return subsets
end