-- Rid.lua: rid()
-- Gets rid of private globals so they dont conflict with user's globals
-- If its called without arguments, sets defined globals (including itself) to nil and proceeds to collect garbage

return function(of)
  local of = of or 'rid'
  _G[of] = ((of and nil) or (function() PATH, BASE, LIBS_PATH, import, utils = nil; collectgarbage() end)())
end