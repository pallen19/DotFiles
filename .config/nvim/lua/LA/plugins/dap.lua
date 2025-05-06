return {
    'mfussenegger/nvim-dap',
    dependencies = {
        -- Creates a beautiful debugger UI / That has built in functions that can be leveraged to do different unique things that we may want as part of our debugging experience
        'rcarriga/nvim-dap-ui',
        -- Virtual text
        'theHamsta/nvim-dap-virtual-text',
        -- Required dependency for nvim-dap-ui
        'nvim-neotest/nvim-nio',
        -- Installs the debug adapters for you
        'williamboman/mason.nvim',
        'jay-babu/mason-nvim-dap.nvim',
        'folke/snacks.nvim'
    },

    config = function()
        local dap = require 'dap'
        local dapui = require 'dapui'
        local keymap = vim.keymap

        -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
        keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

        dap.listeners.after.event_initialized['dapui_config'] = dapui.open
        dap.listeners.before.event_terminated['dapui_config'] = dapui.close
        dap.listeners.before.event_exited['dapui_config'] = dapui.close
        -- Basic debugging keymaps, feel free to change to your liking!
        keymap.set('n', '<localleader>sc', dap.continue, { desc = 'Debug: Start/Continue' })
        keymap.set('n', '<localleader>si', dap.step_into, { desc = 'Debug: Step Into' })
        keymap.set('n', '<localleader>sn', dap.step_over, { desc = 'Debug: Step Over' })
        keymap.set('n', '<localleader>so', dap.step_out, { desc = 'Debug: Step Out' })
        keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
        keymap.set('n', '<leader>B', function()
            dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end, { desc = 'Debug: Set Breakpoint' })

        keymap.set({ 'n', 'v' }, '<Leader>dh', function()
            require('dap.ui.widgets').hover()
        end)
        keymap.set({ 'n', 'v' }, '<Leader>dp', function()
            require('dap.ui.widgets').preview()
        end)
        keymap.set('n', '<Leader>df', function()
            local widgets = require('dap.ui.widgets')
            widgets.centered_float(widgets.frames)
        end)
        keymap.set('n', '<Leader>ds', function()
            local widgets = require('dap.ui.widgets')
            widgets.centered_float(widgets.scopes)
        end)

        require('mason-nvim-dap').setup()
        dapui.setup()
        require("nvim-dap-virtual-text").setup {}

        dap.adapters.chrome = {
            type = "executable",
            command = "node",
            args = { os.getenv("HOME") .. "/path/to/vscode-chrome-debug/out/src/chromeDebug.js" } -- TODO adjust
        }
        --NOTE: change this to javascript if needed
        dap.configurations.javascriptreact = {
            {
                type = "chrome",
                request = "attach",
                program = "${file}",
                cwd = vim.fn.getcwd(),
                sourceMaps = true,
                protocol = "inspector",
                port = 9222,
                webRoot = "${workspaceFolder}"
            }
        }

        --NOTE: change to typescript if needed
        dap.configurations.typescriptreact = {
            {
                type = "chrome",
                request = "attach",
                program = "${file}",
                cwd = vim.fn.getcwd(),
                sourceMaps = true,
                protocol = "inspector",
                port = 9222,
                webRoot = "${workspaceFolder}"
            }
        }
        -- require('netcoredbg-macOS-arm64').setup(dap)

        local function get_plugin_directory()
            local str = debug.getinfo(1, "S").source:sub(2)
            str = str:match("(.*/)")               -- Get the directory of the current file
            return str:gsub("/[^/]+/[^/]+/$", "/") -- Go up two directories
        end

        -- local plugin_directory = get_plugin_directory()
        local netcoredbg_path = "/Users/paul.allen/netcoredbg/bin./netcoredbg"

        dap.adapters.coreclr = {
            type = 'executable',
            command = netcoredbg_path,
            args = { '--interpreter=vscode' }
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
            -- local regexPattern = '%a(.)%a(.)%a(.)Api/bin/Debug/net8.0/%a(.)%a(.)%a(.)Api.dll'
            local regexPattern = '/src/CAL.CD.PermissionsService.Api/bin/Debug/net8.0/CAL.CD.PermissionsService.Api.dll'
            local pattern = vim.fn.getcwd() .. regexPattern
            if not file_exists(pattern) then
                return vim.fn.getcwd()
            end
            local command = 'find "' .. pattern .. '" -maxdepth 1 -type d -name "*net*" -print -quit'
            local handle = io.popen(command)
            if handle ~= nil then
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
        end

        local snacks = require "snacks"
        local environment = {}
        local function findAppSettingspath()
            local pattern = vim.fn.getcwd() .. '/src/%a(.)%a(.)%a(.)Api/' .. environment[1][1]
            print(pattern)
            local command = 'find"' .. pattern
            local path = io.popen(command)
            if path ~= nil then
                return path
            else
                return "nofilefound"
            end
        end

        local function getEnvironmentUrl()
            local fileName = vim.fn.getcwd() ..
            "/src/CAL.CD.PermissionsService.Api/appsettings." .. environment[1] .. ".json"
            -- local fileName = findAppSettingspath()
            -- print(fileName)
            -- local lines = {}
            -- for line in io.lines(fileName, "L") do -- line is the variable created to parse through io.lines
            --     lines.insert(line)
            -- end
            -- for k,v in ipairs(lines) do
            --                         print(k .. ":" .. v)
            --                         end
            -- print(lines[environment[1]])
             print(vim.json.decode(fileName))
            -- return vim.fn.input('Path to dll ', get_dll_path(), 'file')
        end
        dap.configurations.cs = {
            {
                type = 'coreclr',
                name = 'NetCoreDbg: Launch',
                request = 'launch',
                cwd = '${fileDirname}',
                --TODO: Here we should be able to create a function and then parse JSON and grab the correct key-value pair for `development` setup vs docker below
                program =
                    function()
                        local fileName = get_dll_path()
                        if file_exists(fileName) then
                            return fileName
                        end
                    end,
                env = {

                    --TODO: Figure out why it doesn't wait for us to select anyvalues and just throws the nvim dap ui immediately after
                    ASPNETCORE_ENVIRONMENT = function()
                        return coroutine.create(function(dap_run_co)
                            local items = { "development", "docker" }
                            snacks.picker.select(items,
                                { prompt = "Select the intended environment:" },
                                function(item)
                                    environment = { item }
                                    coroutine.resume(dap_run_co, item)
                                end)
                        end)
                    end,
                    ASPNETCORE_URLS = function()
                        return coroutine.create(function(dap_run_co_url)
                            snacks.picker.select(
                            { "http://localhost:15900", "http://localhost:15700/permissions-service",  "http://localhost:15500", "http://localhost:15510",  "http://localhost:14900"},
                                -- TODO: Get the read from file working that way we can parse the url based on the file
                                -- { getEnvironmentUrl() },
                                {
                                    prompt = "Select corresponding testing Url" },
                                function(choice)
                                    coroutine.resume(dap_run_co_url, choice)
                                end)
                        end)
                    end,
                },
                command = netcoredbg_path
            },

            --[[ {
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
                } ]]
            -- },
        }

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

        function file_exists(file)
            local f = io.open(file, "rb")
            if f then f:close() end
            return f ~= nil
        end
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
    vim.keymap.set('n', '<leader>ns', "<cmd>:lua require('neotest').summary.toggle()<cr>",
        { desc = 'Show Summary of Tests' }),


}
