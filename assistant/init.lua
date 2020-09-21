require(((context ~= nil and context .. '.') or '') .. 'definitions')
LIBS_PATH = ((context ~= nil and context .. '.libs.') or 'libs.')
utils = import('utils.index')
local sheet = import('classes.sheet')
assistant = {
  sheet = sheet
}

rid(); return assistant