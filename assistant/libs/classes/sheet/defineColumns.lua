-- sheet.lua
-- Returns a table whose keys are labels that refer to a certain index of the table (pointers)

return function(data, columnNames, prefix, suffix)
  if not columnNames or next(columnNames) == nil then return {} end
  local pointers = {}
  local i = 0
  for index, name in ipairs(columnNames) do
    if data[name]~=nil then
      pointers[prefix .. name .. suffix] = name
    else
      i = i + 1
      pointers[prefix .. columnNames[index] .. suffix] = i
    end
  end
  return pointers
end