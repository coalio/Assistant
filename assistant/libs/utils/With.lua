-- With.lua: with()
-- Merges tables that usually contain prototype functions

return function(...)
  if #{...} == 1 then local p = {...} return p[1] end
  return (function(x)
    local merged = {}
    for _,table in pairs(x) do
      for key, value in pairs(table) do
        merged[key] = value
      end
    end
    return merged
  end) ({...})
end