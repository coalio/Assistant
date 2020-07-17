-----------------------------------------------------------------------------
-- Assistant loader
-- This .lua file allows you to configure fallbacks in case importing Assistant fails

-- In some projects where Assistant might be included as a dependency, these fallbacks
-- will avoid naive importing errors, however, YOU should take personal care of importing it correctly
-- (this topic was also covered in the Assistant documentation, please take a look at #distribution)
-- these fallbacks are designed for development/testing errors only.

--      a. You can replace the below string with an absolute path to the folder that contains assistant directory
--      b. You can install Assistant using a package manager
--      c. You can use a different lua interpreter that allows loading folders via relative path

-- If the lua interpreter is at the current working directory, you can import assistant as
--      "require(assistant)" > "./assistant/init.lua"

-- For production, you should instead manage Assistant import manually by adding the directory to package.path
-----------------------------------------------------------------------------

local debug = false

local vararg, CURRENT_DIRECTORY = (...),
((package.config:sub(1,1)==[[\]] and io.popen"cd":read'*l') or 
--<Replace this string for an absolute path to Assistant if you're having trouble>
  [[<Replace this string for an absolute path to Assistant if you're having trouble>]]
)

-----------------------------------------------------------------------------
-- Fallbacks in case require('assistant') does not work 
-- (it happens often, really)
-----------------------------------------------------------------------------
_G['assistant']=_;
local libname=((
  (vararg:match('(.-)[^%.]+$')~='' and 
  vararg:match('(.-)[^%.]+$')) and 
  vararg:match('(.-)[^%.]+$')..'.assistant') 
  or 'assistant'
)
local init = (function(at)
  package.path = package.path .. ';'..(CURRENT_DIRECTORY .. '/?.lua')
  vararg = 'assistant'
  require(((vararg~=nil and vararg .. '.') or '') .. 'definitions')
  LIBS_PATH = ((vararg~=nil and vararg .. '.libs.') or 'libs.')
  utils = import('utils.index')
  local Matrix = import('classes.Matrix')
  local Sheet = import('classes.Sheet')
  assistant = {
    Sheet = Sheet, 
    Matrix = Matrix
  }
  rid(); return assistant
  end)
xpcall(function() assistant = init() end, 
function(e) if CURRENT_DIRECTORY:len()==79 and CURRENT_DIRECTORY:sub(1,1)=='<' then print([[
################################################################
Your current lua interpreter seems to be running file 
]] .. arg[0] .. [[ from an unexpected path (such as the current lua bin path)
However, this issue wont allow Assistant to load.
You can try providing an absolute path to assistant at CURRENT_DIRECTORY constant inside assistant.lua file

If that does not work, consider moving to a different lua interpreter that provides a relative path
################################################################
]]) else print('Assistant (assistant/) folder was not found at "'..CURRENT_DIRECTORY..'"\n'..((debug and e or '') or 'Toggle debug if you want to see the complete error output')) end end)
return assistant 