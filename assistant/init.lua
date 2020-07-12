-- Assistant Library
require((((...)~=nil and (...) .. '.') or '') .. 'definitions')
LIBS_PATH = (((...)~=nil and (...) .. '.libs.') or 'libs.')
-- Utils
utils = import('utils.index')
-- Public classes
local Matrix = import('classes.Matrix')
local Sheet = import('classes.Sheet')
-- Public modules

assistant = {
  Sheet = Sheet, 
  Matrix = Matrix
}

rid(); return assistant