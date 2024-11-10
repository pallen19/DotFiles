--[[ return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- 'Cliffback/netcoredbg-macOS-arm64.nvim',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',
    -- Virtual text
    'theHamsta/nvim-dap-virtual-text',
    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim'
      },

 config = function ()

local M = {}

--- Rebuilds the project before starting the debug session
---@param co thread
local function rebuild_project(co, path)
  local spinner = require("easy-dotnet.ui-modules.spinner").new()
  spinner:start_spinner("Building")
  vim.fn.jobstart(string.format("dotnet build %s", path), {
    on_exit = function(_, return_code)
      if return_code == 0 then
        spinner:stop_spinner("Built successfully")
      else
        spinner:stop_spinner("Build failed with exit code " .. return_code, vim.log.levels.ERROR)
        error("Build failed")
      end
      coroutine.resume(co)
    end,
  })
  coroutine.yield()
end

M.register_net_dap = function()
  local dap = require("dap")
  local dotnet = require("easy-dotnet")
  local debug_dll = nil

  local function ensure_dll()
    if debug_dll ~= nil then
      return debug_dll
    end
    local dll = dotnet.get_debug_dll()
    debug_dll = dll
    return dll
  end

  for _, value in ipairs({ "cs", "fsharp" }) do
    dap.configurations[value] = {
      {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        env = function()
          local dll = ensure_dll()
          local vars = dotnet.get_environment_variables(dll.project_name, dll.relative_project_path)
          return vars or nil
        end,
        program = function()
          local dll = ensure_dll()
          local co = coroutine.running()
          rebuild_project(co, dll.project_path)
          return dll.relative_dll_path
        end,
        cwd = function()
          local dll = ensure_dll()
          return dll.relative_project_path
        end,

      }
    }
  end

  dap.listeners.before['event_terminated']['easy-dotnet'] = function()
    debug_dll = nil
  end


    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })


  dap.adapters.coreclr = {
    type = "executable",
    command = "netcoredbg",
    args = { "--interpreter=vscode" },
  }
end

return M

end
} ]]
--     -- Dap UI setup
--     -- For more information, see |:help nvim-dap-ui|
--     dapui.setup {
--       -- Set icons to characters that are more likely to work in every terminal.
--       --    Feel free to remove or use ones that you like more! :)
--       --    Don't feel like these are good choices.
--       icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
--       controls = {
--         icons = {
--           pause = '⏸',
--           play = '▶',
--           step_into = '⏎',
--           step_over = '⏭',
--           step_out = '⏮',
--           step_back = 'b',
--           run_last = '▶▶',
--           terminate = '⏹',
--           disconnect = '⏏',
--         },
--       },
--
--     }
--   end,
-- }
return {}
