-- Import.lua: import()
-- Imports a lua file safely

return function(filename, path)
  local path, file = path or LIBS_PATH, nil
  xpcall(
    function()
      file = require(path .. filename)
    end
    ,
    function(err)
      print('[Import.lua] error in ' .. filename)
      print(err:sub(1, 2540) .. ' ...')
    end
  )
  return file
end
