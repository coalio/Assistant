-- sheet.lua: reference()
-- Allows you to work with data via reference, however, the data is lost if the source is deleted.

return function(data, reference, from)
  setmetatable(reference, {
    __index = function(index)
      return data[from][index]
    end,
    __mode = 'kv'
  })
end