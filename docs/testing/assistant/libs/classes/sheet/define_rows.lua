-- sheet.lua
-- Returns a table whose keys are labels that refer to a certain index of the table (pointers)

return function(data, row_names, prefix, suffix)
  if not row_names or next(row_names) == nil then return {} end
  local pointers = {}
  local i = 0
  for index, name in ipairs(row_names) do
    if data[name]~=nil then
      pointers[prefix .. name .. suffix] = name
    else
      i = i + 1
      pointers[prefix .. row_names[index] .. suffix] = i
    end
  end
  return pointers
end