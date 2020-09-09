-- sheet.lua
-- Returns a table whose keys are labels that refer to a certain index of the table (pointers)

return function(data, column_names, prefix, suffix)
  if not column_names or next(column_names) == nil then return {} end
  local pointers = {}
  local i = 0
  for index, name in ipairs(column_names) do
    if data[name]~=nil then
      pointers[prefix .. name .. suffix] = name
    else
      i = i + 1
      pointers[prefix .. column_names[index] .. suffix] = i
    end
  end
  return pointers
end