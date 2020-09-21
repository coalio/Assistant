-- DefineClass.lua: defineClass()
-- Checks if all the arguments passed to class:new() are of an accepted type.
-- Checks if required arguments (such as { data }) are missing

return function(name, propertyTypes, arguments) -- Assert would make this "too hard" to read.
  local next = next
  local o = {}
  for _, vararg in pairs(arguments) do
    if type(vararg) == 'table' then
      for _, requiredArg in pairs(propertyTypes['required']) do
        if not vararg[requiredArg] and not o[requiredArg] then
          error(requiredArg .. ' is a required argument for ' .. name)
        end
      end
      for propertyIndex, property in pairs(vararg) do
        if propertyTypes[propertyIndex] == nil then 
          error(propertyIndex .. ' is not a valid argument') 
        end
        if type(property) == propertyTypes[propertyIndex][1] then
          if not property or (propertyTypes[propertyIndex][1] == 'table' and next(property) == nil) then
            error(propertyIndex .. " can't be nil or empty")
          end
          o[propertyIndex] = property
          if type(property) == 'table' and propertyTypes[propertyIndex][2] == 'named_args' then
            for propertyName, propertyValue in pairs(property) do
              if propertyTypes[propertyName] == nil then 
                error(propertyName .. ' is not a valid argument') 
              end      
              if type(propertyValue) ~= tostring(propertyTypes[propertyName][1]) then
                error(propertyName .. ' is not of valid type: ' .. propertyTypes[propertyName][1])
              end
            end
          end
        else
          error(propertyIndex .. ' is not of valid type: ' .. propertyTypes[propertyIndex][1])
        end
      end
    else
      error('new() takes tables as named arguments')
    end
  end
  return o
end

