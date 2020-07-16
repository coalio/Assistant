-- Pointer.lua: pointer()
-- Returns a metatable whose items can be linked (refer) to different items or names

return function(table, pointers, prototype)
  local pointers, prototype = pointers or {}, prototype or {}
  prototype.addPointer = function(pointer) pointers[#pointers+1] = pointer end
  local o = table
  setmetatable(o, {
    __index = function(self, index)
      if index == '_prototype' then return prototype end
      if index == '_pointers' then return pointers end
      if prototype[index] then return prototype[index] end
      if pointers[index] then return rawget(self, pointers[index]) end
    end,
    __newindex = function(self, index, value)
      if pointers[index] then rawset(self, pointers[index], value) end
    end
  })

  return o
end