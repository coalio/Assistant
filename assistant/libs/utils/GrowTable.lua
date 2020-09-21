-- GrowTable.lua: growTable()
-- Allows to copy data from a table from "at" to "n", or start an empty table and grow it

return function(data, n, at) 
  -- T{n}, T{data, n}, T{data, n, at}
  if type(data) == 'number' then n = data; data = {} end
  if not n then return data end
  local t = {}
  for i = at or 0, n do
    t[i] = (data or {})[i]
  end
  return t
end