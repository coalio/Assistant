-- sheet.lua: select()
-- Selects specific series

return function(data, ...)
  if #{...} == 1 then 
    local p = {...}
    local series = data[p[1]]
    if type(series) == 'table' then setmetatable(series, getmetatable(data)) end
    return series
  end

  local subsets = {}
  for _, name in pairs({...}) do
    subsets[name] = data[name]
  end
  setmetatable(subsets, getmetatable(data))
  return subsets
end