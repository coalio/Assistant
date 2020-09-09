--[[
  Assistant: Testing Suite
]]

print -->
[[
Test ID:

>> 1. nested_data_1.lua: indexing via labels (pointers)
>> 2. nested_data_2.lua: naming columns and indexing methods
>> 3. print_data_1.lua: naming and ordering data by labels, then displaying via print
>> 4. large_data_1.lua: test of performance against large datasets
]]

Tests = {
  'nested_data_1.lua',
  'nested_data_2.lua',
  'print_data_1.lua',
  'large_data_1.lua'
}

--[[
  Configuration:

  lua unit_testing.lua arg1 arg2

  arg1: Specify the ID of the test to load
  arg2: Specify if the test should be sandboxed, in that case, ENVIRONMENT is used as _ENV
]]

local Default_TestID = arg[1] or ( 1 ) -- Test to run if not provided in RunTest
local Default_Sandboxed = ((arg[2]=='true' and true) or false) or ( false ) -- Provide a limited environment

-- Environment that will be available for functions ran within sandbox

local ENVIRONMENT = {
  require = require,
  io = io,
  tonumber = tonumber,
  rawset = rawset,
  type = type,
  error = error,
  next = next,
  tostring = tostring,
  os = os,
  print = print,
  dofile = dofile,
  select = select,
  collectgarbage = collectgarbage,
  bit32 = bit32,
  xpcall = xpcall,
  math = math,
  getmetatable = getmetatable,
  assert = assert,
  string = string,
  table = table,
  setmetatable = setmetatable,
  package = package,
  ipairs = ipairs,
  pairs = pairs,
  rawget = rawget,
  unpack = table.unpack or unpack,
  arg = arg
}

-- Functions

local SetForRun = {Default_TestID, Default_Sandboxed}
function RunTest(TestID, Sandboxed)
  TestID = TestID or Default_TestID
  Sandboxed = Sandboxed or Default_Sandboxed

  TestID = tonumber(TestID)
  if TestID == nil then return elseif TestID < 0 then return end
  if not Tests[TestID] then print("There is no test with ID " .. TestID) return 0,0 end

  -- Get a handle for the test by ID

  TestFile = io.open('tests/'..Tests[TestID]):read('*a')
  if not TestFile then print("Test provided is empty") return 0,0 end

  -- Create the sandbox or load at the absolute environment
  TimerStart = os.clock()
  if Sandboxed then
    local UntouchedGlobal = growFrom(_G)
    if _VERSION == 'Lua 5.1' then
      TestFunction, message = load(TestFile)
      if not TestFunction then print(message) return 0,0 end
      setfenv(TestFunction, env)

    elseif _V.MAJOR >= '5' and _V.MINOR >= '2' then
      TestFunction, message = load(TestFile, nil, 't', ENVIRONMENT)
      if not TestFunction then print(message) return 0,0 end

    end
    output, message = pcall(TestFunction); print(message or '')
    _G = UntouchedGlobal; collectgarbage()
  else
    output, message = pcall(load(TestFile)); print(message or '')
  end
  
  -- Return timestamps
  return TimerStart, os.clock()
end

--[[

    ----------------------------------------
      Compatibility and other workarounds
    ----------------------------------------
  
  Backwards compatibility for Lua 5.1/5.2/5.3
]]

package.path = package.path .. ';./tests/?.lua'

_V = {
  MAJOR = _VERSION:sub(5,5), -- Lua 5.x.x
  MINOR = _VERSION:sub(7,7), -- Lua x.1.x
  PATCH = _VERSION:sub(#_VERSION,#_VERSION), -- Lua x.x.5
};

getMajorAndMinor = function(version)
  return version:sub(5,5), ((
    tonumber(version:sub(7,7)) and version:sub(7,7)
  ) or 
    (function() 
      for i = #version, 1, -1 do
        minor = tonumber(version:sub(7,7))
        if minor then
          return minor
        end
      end
      return '?'
    end) ()
  )
end

-- Clones a table, therefore dereferencing it's content from the original source
iterlayer = 0
growFrom = function(table)
  local o = {}
  for k,v in pairs(table) do
    o[k] = v
  end
  return o
end

DeclareInVersion = function(name, versionMeet, value) -- Declare only if version meets
  -- versionMeet can be either a string and a boolean
  -- boolean: (_VERSION.MAJOR>=5 and _VERSION.MINOR>=1)
  -- string: ("Lua 5.1+")
  if type(versionMeet) == 'string' then
    local Major, Minor = getMajorAndMinor(versionMeet)
    -- Declare for this version or higher
    isInclusive = versionMeet:sub(#versionMeet, #versionMeet)
    if isInclusive == '+' then
      versionMeet = ((Major>=_V.MAJOR and Minor>=_V.MINOR) or false)
    else
      versionMeet = ((Major==Major and Minor==Minor) or false)
    end
  elseif type(versionMeet)~='boolean' then
    error("VersionMeet is invalid: " .. versionMeet)
  end

  if versionMeet then
    _G[name] = value
  end
end

--[[  Assistant is incompatible with Lua 5.0 and below ]]
--[[  load: implemented until Lua 5.2 ]]
DeclareInVersion("load", ("Lua 5.1"), (loadstring or load))
--[[  unpack: removed in Lua 5.2 ]]
DeclareInVersion("unpack", ("Lua 5.2+"), (table.unpack or unpack))
--[[  setfenv: removed in Lua 5.2 ]]
DeclareInVersion("setfenv", ("Lua 5.2+"), function(fn, env)
  for i = 1, math.huge do
    local name = debug.getupvalue(fn, i)
    if name == "_ENV" then
      debug.upvaluejoin(fn, i, (function()
        return env
      end), 1)
      break
    elseif not name then
      break
    end
  end

  return fn
end)

RunTest(unpack(SetForRun))

while true do
  -- Ask the user for a test ID
  repeat
    io.write("Specify which test ID to load >> ")
    io.flush()
    TestID = io.read()
  until TestID
  print()
  -- Convert to number
  TestID = tonumber(TestID)
  -- Verify if the user introduced a valid ID, otherwise, leave
  if not TestID then
    print('\nLeaving unit testing')
    os.exit(0)
    break
  else
    -- TimerStart and TimerStop are timestamps to determine how long the test took to finish
    TimerStart, TimerStop = RunTest(TestID, Default_Sandboxed)
    print('\nTest finished in [' .. TimerStop - TimerStart .. ']\n')
  end
end