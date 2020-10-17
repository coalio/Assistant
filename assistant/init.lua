require((((...) ~= nil and (...) .. '.') or '') .. 'definitions')
LIBS_PATH = (((...) ~= nil and (...) .. '.lib.') or 'lib.')
utils = import('utils.index')
local sheet = import('classes.sheet')
assistant = {
  sheet = sheet
}

rid(); return assistant