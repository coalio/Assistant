-- A small support chat

local Assistant = require('assistant')

local Question = 'Who am i'

local questions = {'Who is that', 'Who am i', 'Where am i'}
local answers = {"Oh, that's my mom", 'Im coal', 'In a lua program'}
local Sentences = Assistant.Sheet:new {data = {questions, answers}, properties= {
  allowDuplicates = false
  }
}

local answer_index = Sentences:Find(Question, questions)
print(answers[answer_index])