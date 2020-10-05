-- sheet.lua: max()
-- Returns the maximum within data or n of them

local checkArguments = utils.checkArguments
local growTable = utils.growTable
local parameterTypes = {
  'table',
  'number'
}

return function(data, n)
  parameters = {data, n}
  if checkArguments((data['_type'] or 'sheet') .. ':max', parameterTypes, parameters) == -1 then
    return
  end

  if not n then return math.max(unpack(data)) end
  local t = (function() local a={} for k,v in next, data, nil do a[k]=v end return a end)()
  table.sort(t, function(at, of) return at > of end)
  return growTable(t, n)
end