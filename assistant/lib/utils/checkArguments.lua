-- ParameterCheck.lua: parameterCheck()
-- Checks if all arguments passed to the function are valid

local raiseError = require(BASE(..., 'raiseerror'))
return function(parameterName, types, parameters)
  for parameterName, parameter in pairs(parameters) do
    local lw = types[parameterName]:gsub('(.+)%|', '')
    local rw = types[parameterName]:gsub('%|(.+)', '')
    if type(parameter)~=lw and type(parameter)~=rw then
      raiseError(2, parameterName, parameters, 'parameter ' .. parameterName .. ' must be of type '
        .. types[parameterName])

      return -1
    end
  end

  -- If all arguments are valid, return 0
  return 0
end