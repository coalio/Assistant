-- Import.lua: import()
-- Imports a lua file safely and without allowing it to declare any globals except for return values

return function(filename, path)
  local path, file = path or LIBS_PATH, nil
  xpcall(
    function()
      file = require(path .. filename)
    end
    ,
    function(err)
      print('[Import.lua] error in ' .. filename)
      print(err:sub(1, 142) .. ' ...')
    end
  )
  return file
end
