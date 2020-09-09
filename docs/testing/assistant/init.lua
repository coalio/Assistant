-- Assistant Library
require((((...)~=nil and (...) .. '.') or '') .. 'definitions')
LIBS_PATH = (((...)~=nil and (...) .. '.libs.') or 'libs.')
-- Utils
utils = import('utils.index')
-- Public classes
local Sheet = import('classes.Sheet')
-- Public modules

assistant = {
  -- Classes
  Sheet = Sheet, 

  -- Modules
  CSV = CSV
}

rid(); return assistant