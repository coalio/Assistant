-- matrix.lua
-- Returns a table containing labels that point to a certain index of the table

return function(data, column_names)
  if not column_names or next(column_names) == nil then return {} end
  local pointers = {}
  for index, name in ipairs(column_names) do
    pointers[#pointers + 1] = {index, name}
  end
  return pointers
end