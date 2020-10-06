-- fallback.lua: fallback()
-- A fallback helps to reduce long ternaries and makes the code easier to learn

return function(fallbacksTable)
  local fallbacks = {}
  local parameterNames = {}
  local resultingFallbacks = {}
  for i, fallback in pairs(fallbacksTable) do
      parameterNames[i] = fallback[1]
      fallbacks[fallback[1]] = fallback[2] and fallback[3] or fallback[4]
  end

  table.sort(parameterNames)
  for i = 1, #parameterNames do
    resultingFallbacks[#resultingFallbacks + 1] = fallbacks[parameterNames[i]]
  end

  return unpack(resultingFallbacks)
end