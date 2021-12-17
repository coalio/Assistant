-- parameterCheck.lua: parameterCheck()
-- Checks if all arguments passed to the function are valid

return function(functionName, types, parameters)
  for parameterIndex, parameter in pairs(parameters) do
    local lw = types[parameterIndex]:gsub('(.+)%|', '')
    local rw = types[parameterIndex]:gsub('%|(.+)', '')
    if type(parameter)~=lw and type(parameter)~=rw then
      raiseError(2, functionName, parameters, 'parameter ' .. parameterIndex .. ' must be of type '
        .. types[parameterIndex])

      return -1
    end
  end

  -- If all arguments are valid, return 0
  return 0
end
