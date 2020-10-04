-- GrowTable.lua: growTable()
-- Allows to copy data from a table from "at" to "n", or start an empty table and grow it

return function(data, n, at, step) 
  -- growTable(n), growTable(data, n), growTable(data, n, at), growTable(data, n, at, step)
  if type(data) == 'number' then n = data; data = {} end
  if not n then return data end
  local step = step or 1
  local t = {}
  for i = at or 0, n, step do
    t[i] = (data or {})[i]
  end
  return t
end