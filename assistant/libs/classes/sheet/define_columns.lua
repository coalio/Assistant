-- sheet.lua
-- Returns a table whose keys are labels that refer to a certain index of the table (pointers)

return function(data, column_names)
  if not column_names or next(column_names) == nil then return {} end
  local pointers = {}
  for index, name in ipairs(column_names) do
    pointers[name] = index
  end
  return pointers
end