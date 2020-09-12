-----------------------------------------------------------------------------
-- Collection of utilities used internally
-----------------------------------------------------------------------------
-- Used to shorten some path references when importing files
PATH = function(at, to) return (at or ' ') .. "." .. to end
BASE = function(at, to) return (at or ' '):match('(.-)[^%.]+$') .. to end
-----------------------------------------------------------------------------
-- Functions used internally
rid = require(BASE(..., 'libs.utils.rid'))
import = require(BASE(..., 'libs.utils.import'))
-- Compatibility
local vlen = string.len(_VERSION)
local minor = tonumber(_VERSION:sub(vlen, vlen))
local major = tonumber(_VERSION:sub(vlen-2, vlen-2))
if major >= 5 and minor >= 3 then -- From Lua 5.3 and above
  unpack = table.unpack
end