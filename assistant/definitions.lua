-- Collection of utilities used internally

-- path
PATH = function(at, to) return (at) .. "." .. to end
BASE = function(at, to) return (at):match('(.-)[^%.]+$') .. to end

-- functions
import = require(BASE(..., 'libs.utils.import'))
rid = require(BASE(..., 'libs.utils.rid'))