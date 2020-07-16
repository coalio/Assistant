-- sheet.lua: max()
-- Returns the maximum within data or n of them

local GrowTable = utils['growtable']
return function(data, n)
  table.sort(data, function(at, of) return at > of end)
  local min = GrowTable(data, n)
  if not n then min = min[1] end
  return min
end