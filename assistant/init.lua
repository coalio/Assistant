require(((context ~= nil and context .. '.') or '') .. 'definitions')
LIBS_PATH = ((context ~= nil and context .. '.lib.') or 'lib.')
utils = import('utils.index')
local sheet = import('classes.sheet')
assistant = {
  sheet = sheet
}

rid(); return assistant