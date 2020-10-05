-- sheet.lua
-- Returns a table whose keys are labels that refer to a certain index of the table (pointers)

return function(data, rowNames, prefix, suffix)
  if not rowNames or next(rowNames) == nil then return {} end
  local pointers = {}
  
  local i = 0; for index, name in ipairs(rowNames) do
    if data[name]~=nil then
      pointers[prefix .. name .. suffix] = name
    else
      i = i + 1
      pointers[prefix .. rowNames[index] .. suffix] = i
    end
  end
  return pointers
end