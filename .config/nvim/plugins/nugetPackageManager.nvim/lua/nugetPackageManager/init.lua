local picker = require "snacks.picker"
local config = require "snacks.picker.config".values
local M = {}

--[[ M.nuget = function ()
    vim.api.nvim_create_buf()
    
end 

local collection = {"SeriLog","AspNet","InMemoryCache"}
    M.show_nuget_packages = function(collection)
    picker.pick("zoxide", config)
    --[[ picker.select(collection,
        { prompt = "Select the nuget package to install:" },
        function(item)
            return item
        end) ]]
-- end

    ---Attempting to create a new picker using snacks nvim example of zoxide. 
    ---@param opts any
    ---@param ctx any
    ---@return unknown
    function M.zoxide(opts, ctx)
  return require("snacks.picker.source.proc").proc({
    opts,
    {
      cmd = "dotnet",
      args = { "nuget", "list", "source" },
      ---@param item snacks.picker.finder.Item
      transform = function(item)
        item.sources = item.value
      end,
    },
  }, ctx)
end

-- M.show_nuget_packages(collection)
M.configure = function()
end
 local opts = {
  finder = "files_zoxide",
  format = "file",
  confirm = "load_session",
  win = {
    preview = {
      minimal = true,
    },
  },
}
-- M.zoxide(opts, ctx)
return M
