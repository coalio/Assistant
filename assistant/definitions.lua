-----------------------------------------------------------------------------
-- Collection of utilities used internally
-----------------------------------------------------------------------------
-- Used to shorten some path references when importing files
PATH = function(at, to) return (at or ' ') .. "." .. to end
BASE = function(at, to) return (at or ' '):match('(.-)[^%.]+$') .. to end
-----------------------------------------------------------------------------
-- Functions used internally
import = require(BASE(..., 'libs.utils.import'))
rid = require(BASE(..., 'libs.utils.rid'))