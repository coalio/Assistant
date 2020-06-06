-- Assistant Library

local LARGEST_INDEX = 65536

assistant = {
  log = {
    [0] = {},
    {}, -- Released objects within Assistant may be logged here (Dimension 1)
    {}, -- Inputs received by Assistant may be logged here (Dimension 2)
    {}, -- Outputs returned by Assistant may be logged here (Dimension 3)
    {} -- Calls done by the user/Assistant may be logged here (Dimension 4)
  },
  TrackGarbageCollection = function(object)
    -- Metamethod __gc
    local log = 'Garbage Collection: '..object._name..' is no longer in use'
    assistant.log[1][#assistant.log[1] +1] = log
    assistant.log[0][#assistant.log[0] +1] = log
  end,
  TrackInput = function (object)
    -- Log inputs
    local log = 'Input: '..object._name..' has entered '..object._action
    assistant.log[2][#assistant.log[2] +1] = log
    assistant.log[0][#assistant.log[0] +1] = log
  end,
  TrackOutput = function (object)
    -- Log outputs
    local log = 'Output: '..object._name..' performed to '..object._action 
    assistant.log[3][#assistant.log[3] +1] = log
    assistant.log[0][#assistant.log[0] +1] = log
  end,
  TrackCall = function (object)
    -- Log calls made either within Assistant or external
    local log = 'Call: '..object._name..' called '..object._action
    assistant.log[4][#assistant.log[4] +1] = log
    assistant.log[0][#assistant.log[0] +1] = log
  end,
  -- Public
  getLogs = function (dimension, index)
    local dimension = dimension or 0
    if not index then
      return assistant.log[dimension]
    else
      return assistant.log[dimension][index]
    end
  end
}

-- Utils

Memoize = require('utils.memoize')

-- Internal utils

_set_class = require('utils.arguments')

-- Public classes

assistant.Sheet = require('classes.sheet')

-- Public modules

assistant.Matrix = require('modules.matrix')

return assistant