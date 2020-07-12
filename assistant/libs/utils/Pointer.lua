-- Pointer.lua: pointer()
-- Returns a metatable whose items can be linked (refer) to different items or names

return function(table, pointers, prototype)
  prototype.addPointer = function(pointer) pointers[#pointers+1] = pointer end
  local o = table
  setmetatable(o, {
    __index = function(self, index)
      if prototype[index] then return prototype[index] end
      for k,v in ipairs(pointers) do
        if v[2] == index then return rawget(self, v[1]) end
      end
    end,
    __newindex = function(self, index, value)
      for k,v in ipairs(pointers) do
        if v[2] == index then rawset(self, v[1], value) end
      end
    end
  })

  return o
end