-- sheet.lua
-- Returns a table whose keys are labels that refer to a certain index of the table (pointers)

return function(data, row_names)
  if not row_names or next(row_names) == nil then return {} end
  local pointers = {}
  for index, name in ipairs(row_names) do
    pointers[name] = index
  end
  return pointers
end