-----------------------------------------------------------------------------
-- Assistant loader
-- This .lua file allows you to configure fallbacks in case importing Assistant fails

-- In some projects where Assistant might be included as a dependency, these fallbacks
-- will avoid naive importing errors, however, YOU should take personal care of importing it correctly
-- these fallbacks are designed for quick development/testing.

--      a. You can replace the below string with an absolute path to the folder that contains assistant directory
--      b. You can install Assistant using a package manager
--      c. You can make "assistant/init.lua" available to LUA_PATH

-- If the lua interpreter is at the current working directory, you can import assistant as
--      "require(assistant)" > "./assistant/init.lua"

-----------------------------------------------------------------------------

--[[ Configuration ]]

local DEBUG = true -- Shows the complete stack for require

-- Do not include "<" or ">"
local CURRENT_DIRECTORY = [[<Replace this string for an absolute path to Assistant if you're having trouble>]]


-----------------------------------------------------------------------------
-- Fallbacks in case require('assistant') does not work 
-- (it happens often, really)
-----------------------------------------------------------------------------

local context = (...)

local isDirPlaceholder = (CURRENT_DIRECTORY:sub(1,1)=='<' 
and CURRENT_DIRECTORY:sub(#CURRENT_DIRECTORY, #CURRENT_DIRECTORY)=='>')

CURRENT_DIRECTORY = ((
  (package.config:sub(1,1)==[[\]] and isDirPlaceholder) 
  and io.popen("cd"):read('*l')) or CURRENT_DIRECTORY
) 

local assistant
local libname=((
  (context:match('(.-)[^%.]+$')~='' and 
  context:match('(.-)[^%.]+$')) and 
  context:match('(.-)[^%.]+$')..'.assistant') 
  or 'assistant'
)

local function init(at)
  package.path = package.path .. ';'..(CURRENT_DIRECTORY .. '/?.lua')
  context = 'assistant'

  require(((context~=nil and context .. '.') or '') .. 'definitions')
  LIBS_PATH = ((context~=nil and context .. '.libs.') or 'libs.')
  utils = import('utils.index')
  
  local Sheet = import('classes.Sheet')
  assistant = {
    Sheet = Sheet,
  }

  rid(); return assistant
end

xpcall(function() assistant = init() end, 
function(e) 
  if isDirPlaceholder then 
    print([[
      
Your current lua interpreter seems to be running file 
]] .. arg[0] .. [[ from an unexpected path (usually the current lua interpreter path)
However, this issue wont allow Assistant to load.

You can try providing an absolute path to assistant at CURRENT_DIRECTORY inside assistant.lua file
If that does not work, consider making Assistant available to your LUA_PATH environment variable
-----
      ]])
  else 
  print('Assistant (assistant/) folder couldnt be imported from "'..CURRENT_DIRECTORY..'"\n'..((debug and e) or '')) end end)
return assistant 