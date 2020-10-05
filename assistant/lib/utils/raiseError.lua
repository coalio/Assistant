-- raiseError.lua: raiseError()
-- Raises an error/warning

--[[
  Error levels:
    0. Info
    1. Warning
    2. Error
]]

return function(errorLevel, where, args, reason)
  local output
  local at = 'Assistant.'..where:match('(.+)[%.%:]')
  if errorLevel < 0 or errorLevel > 2 then return end
  for k, v in pairs(args) do args[k] = tostring(v) end
  print(
    ((errorLevel==0 and '['..at..'.info] ') or 
    ((errorLevel==1 and '['..at..'.warning] ') 
    or '['..at..'.error] ')) .. 
    where .. '(' .. table.concat(args, ', ') .. '): ' .. reason
  )
  io.stdout:write(debug.traceback(nil, 2) and '\n' .. debug.traceback(nil, 2) or '')
end