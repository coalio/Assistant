-- Rid.lua: rid()
-- Gets rid of internal globals so they dont conflict with user's globals
-- If its called without arguments, sets defined globals (including itself) to nil and proceeds to collect garbage
-- Otherwise, sets _G[of] to nil

local rid_of = {
  'T',

  'PATH',
  'BASE',
  'LIBS_PATH',
  'CLASS_PATH',

  'import',
  'utils'
}

return function(of)
  local of = of or 'rid'
  _G[of] = ((of and nil) or (function() for _,v in pairs(rid_of) do _G[v] = nil; end collectgarbage() end)())
end