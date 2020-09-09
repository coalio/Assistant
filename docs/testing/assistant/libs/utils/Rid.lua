-- Rid.lua: rid()
-- If its called without arguments, sets defined globals (including itself) to nil and proceeds to collect garbage
-- Otherwise, sets _G[of] to nil

-- Assistant requires passing environment variables to statically nested scopes, 
-- however, can't be done easily in Lua 5.1.5 or inferior, therefore this offers a backwards-compatible fix
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
  _G[of] = ((of and nil) or (
    function() 
      for _,v in pairs(rid_of) do 
        _G[v] = nil
      end 
    end)())
end