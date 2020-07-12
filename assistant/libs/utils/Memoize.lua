-- Memoize.lua: memoize.*
-- Allows to store results in case they are required later

local memoize = {}
setmetatable(memoize, {__mode = "kv"})

function memoize.add (_function, type, pars)
  self['results'][_function][type][pars] = data.result
end

function memoize.get(_function, type, pars)
  data = self['results'][_function][type][pars]
  if data then return data else return nil end
end

return memoize