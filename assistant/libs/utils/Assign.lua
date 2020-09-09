-- Assign.lua: assign()
-- Returns a metatable whose items can be linked (refer) to different items or names
-- Also assigns metadata such as labels, pointers, and prototype functions

local manageMetadata = {
  append = function(name, value, object)
    object._metadata[name] = value
  end,
  remove = function(name, object)
    object._metadata[name] = nil
  end
}

return function(type, labels, data, pointers, prototype)
  local pointers, prototype = pointers or {}, prototype or {}
  local metadata = {
    ['type']           = type,
    ['labels']         = labels,
    ['data']           = data,
    ['pointers']       = pointers,
    ['prototype']      = prototype,
    ['appendMetadata'] = manageMetadata.append,
    ['removeMetadata'] = manageMetadata.remove
  }

  -- prototype.addPointer(): Allows to add a pointer that references another item
  prototype.addPointer = function(pointer, to) pointers[pointer] = to end
  local object = data
  if next(labels or {})==nil then
    for label in pairs(object) do
      labels[#labels+1] = tostring(label)
    end
    table.sort(labels, function(a,b)
      local na = tonumber(a)
      local nb = tonumber(b)
      if na and nb then return na < nb else return a < b end
    end)
  else
    -- Labels could be numbers so we should convert them to string
    for label_index, label in pairs(labels) do
      labels[label_index] = tostring(label)
    end
  end

  setmetatable(object, {
    __index = function(self, index)
      if prototype[index] then return prototype[index] end
      if pointers[index] then return rawget(self, pointers[index]) end

      -- _: metadata objects use this prefix
      if tostring(index):sub(1,1) == '_' then
        mdname = tostring(index):sub(2,#index)
        if mdname == 'metadata' then
          return metadata
        else
          return metadata[mdname] 
        end
      end
    end,
    __newindex = function(self, index, value)
      if pointers[index] then 
        rawset(self, pointers[index], value)
      else
        rawset(self, #self+1, value)
        pointers[index] = #self
      end
    end
  })

  return object
end