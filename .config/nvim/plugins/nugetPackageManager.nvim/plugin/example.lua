local M = {
}

M.HelloWorld = function()
    return print 'Hello World'
end

---@function Snacks: snacks.nvim
M.picker = function()

    --way to run a command in the terminal
 -- local obj = vim.system({'nuget', 'search'}, { text = true }):wait()
local tbl = setmetatable({}, { __index = table})
    -- print(vim.inspect(tbl))
    --[[ for k, v in pairs(obj) do
        print(v)
        tbl:insert(v)
    end ]]
    
    --Prints text into a new buffer
    --[[ Snacks.win({
      text = "We are back and better",
      position = "float",
      backdrop = 60,
      height = 0.9,
      width = 0.9,
      zindex = 50,
    }) ]]

    -- print(vim.inspect(obj.stdout))
    -- local items = vim.system({'nuget','search', item})
    --[[ local items = { "serilog", "service", "unit", "EFCore" }
    Snacks.picker.select(items, { prompt = 'Select Nuget Package' }, function(item)
        if item ~= nil then
            print(item)
        end
    end) ]]
end
M.HelloWorld()
M.picker()
