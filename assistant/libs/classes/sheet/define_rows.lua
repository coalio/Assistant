-- sheet.lua
-- Returns a table containing labels that point to a certain index of the table

return function(data, row_names)
  if not row_names or next(row_names) == nil then return {} end
  local pointers = {}
  for index, name in ipairs(row_names) do
    pointers[#pointers + 1] = {index, name}
  end
  for k,v in pairs(pointers) do print(k,v[1], v[2]) end
  return pointers
end