-- ParameterCheck.lua: ParameterCheck()
-- Checks if all parameters are of certain type

local raiseError = require(BASE(..., 'raiseerror'))
return function(function_name, types, parameters)
  for parameter_name, parameter in pairs(parameters) do
    local lw = types[parameter_name]:gsub('(.+)%|', '')
    local rw = types[parameter_name]:gsub('%|(.+)', '')
    if type(parameter)~=lw and type(parameter)~=rw then
      raiseError(2, function_name, parameters, 'parameter ' .. parameter_name .. ' must be of type '
        .. types[parameter_name])

      return -1
    end
  end

  -- If all parameters are of valid type, return 0
  return 0
end