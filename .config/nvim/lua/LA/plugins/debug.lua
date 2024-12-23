return {
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

    config = function()
        local dap = require 'dap'
        local dapui = require 'dapui'

        -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
        vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

        dap.listeners.after.event_initialized['dapui_config'] = dapui.open
        dap.listeners.before.event_terminated['dapui_config'] = dapui.close
        dap.listeners.before.event_exited['dapui_config'] = dapui.close
        -- Basic debugging keymaps, feel free to change to your liking!
        vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
        vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
        vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
        vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
        vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
        vim.keymap.set('n', '<leader>B', function()
            dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end, { desc = 'Debug: Set Breakpoint' })

        require('mason-nvim-dap').setup()


        require('netcoredbg-macOS-arm64').setup(require('dap'))

        dap.adapters.netcoredbg = {
            type = 'server',
            port = 80,
        }

        local function getCurrentFileDirName()
            local fullPath = vim.fn.expand('%:p:h')      -- Get the full path of the directory containing the current file
            local dirName = fullPath:match("([^/\\]+)$") -- Extract the directory name
            return dirName
        end

        local function file_exists(name)
            local f = io.open(name, "r")
            if f ~= nil then
                io.close(f)
                return true
            else
                return false
            end
        end

        local function get_dll_path()
            local pattern = '/src/CAL.CD.PermissionsService.Api/bin/Debug/net8.0/CAL.CD.PermissionsService.Api.dll'
            if not file_exists(pattern) then
                return vim.fn.getcwd()
            end
            local command = 'find "' .. vim.fn.getcwd() .. pattern .. '" -maxdepth 1 -type d -name "*net*" -print -quit'
            local handle = io.popen(command)
            local result = handle:read("*a")
            handle:close()
            result = result:gsub("[\r\n]+$", "") -- Remove trailing newline and carriage return
            if result == "" then
                return pattern
            else
                local potentialDllPath = result .. '/' .. getCurrentFileDirName() .. '.dll'
                if file_exists(potentialDllPath) then
                    return potentialDllPath
                else
                    return result == "" and pattern or result .. '/'
                end
                --        return result .. '/' -- Adds a trailing slash if a net folder is found
            end
        end

        local function get_sln_path()
            local current_directory = vim.fn.expand('%:p:h')

            local command = 'find/bin/Debugz'
        end
        dap.configurations.cs = {
            {
                type = 'coreclr',
                name = 'NetCoreDbg: Launch',
                request = 'launch',
                cwd = '${fileDirname}',
                program = function()
                    return vim.fn.input('Path to dll', get_dll_path(), 'file')
                end,
                env = {
                    ASPNETCORE_ENVIRONMENT = function()
                        return vim.fn.input("ASPNETCORE_ENVIRONMENT: ", "development")
                    end,
                    ASPNETCORE_URLS = function()
                        return vim.fn.input("ASPNETCORE_URL: ", "http://localhost:15900")
                    end,
                }
            },

            {
                type = 'coreclr',
                name = 'NetCoreDbg: Docker Debugging',
                request = 'attach',
                port = 15700,
                cwd = '${fileDirname}',
                program = function()
                    return vim.fn.input('Path to dll', get_dll_path(), 'file')
                end,
                processId = '${command:pickProcess}',
                env = {
                    ASPNETCORE_ENVIRONMENT = function()
                        return vim.fn.input("ASPNETCORE_ENVIRONMENT: ", "docker")
                    end,
                    ASPNETCORE_URLS = function()
                        return vim.fn.input("ASPNETCORE_URLS: ", "http://localhost:15700/permissions-service")
                    end,
                }
            },
        }

        dapui.setup()
        require("nvim-dap-virtual-text").setup {}

        local neotest = require 'neotest'
        neotest.setup({
            adapters = {
                require("neotest-dotnet")({
                    dap = {
                        -- Extra arguments for nvim-dap configuration
                        -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
                        args = { justMyCode = false },
                        -- Enter the name of your dap adapter, the default value is netcoredbg
                        adapter_name = "coreclr"
                    },
                    -- Let the test-discovery know about your custom attributes (otherwise tests will not be picked up)
                    -- Note: Only custom attributes for non-parameterized tests should be added here. See the support note about parameterized tests
                    custom_attributes = {
                        xunit = { "MyCustomFactAttribute" },
                        nunit = { "MyCustomTestAttribute" },
                        mstest = { "MyCustomTestMethodAttribute" }
                    },
                    -- Provide any additional "dotnet test" CLI commands here. These will be applied to ALL test runs performed via neotest. These need to be a table of strings, ideally with one key-value pair per item.
                    dotnet_additional_args = {
                        "--verbosity detailed"
                    },
                    -- Tell neotest-dotnet to use either solution (requires .sln file) or project (requires .csproj or .fsproj file) as project root
                    -- Note: If neovim is opened from the solution root, using the 'project' setting may sometimes find all nested projects, however,
                    --       to locate all test projects in the solution more reliably (if a .sln file is present) then 'solution' is better.
                    discovery_root = "solution" -- "project" is the Default value
                })
            }
        })
    end,

    vim.keymap.set('n', '<leader>kt', "<cmd>:lua require('neotest').run.run()<cr>",
        { desc = 'Kick off test under cursor' }),
    vim.keymap.set('n', '<leader>kcf', "<cmd>:lua require('neotest').run.run(vim.fn.expand('%'))<cr>",
        { desc = 'Kick off test in current file' }),
    vim.keymap.set('n', '<leader>dt', "<cmd>:lua require('neotest').run.run({strategy = 'dap'})<cr>",
        { desc = 'Debug nearest test' }),
    vim.keymap.set('n', '<leader>st', "<cmd>:lua require('neotest').run.stop()<cr>",
        { desc = 'Stop running nearest test' }),
    vim.keymap.set('n', '<leader>kat', "<cmd>:lua require('neotest').run.attach()<cr>", { desc = 'Attach test' }),
    vim.keymap.set('n', '<leader>ns', "<cmd>:lua require('neotest').summary.toggle()<cr>", { desc = 'Show Summary of Tests' }),
}
