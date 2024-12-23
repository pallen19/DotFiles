return {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
        local treesitter = require("nvim-treesitter.configs")

        --configure treesitter
        treesitter.setup({ --enable syntax highlighting
            highlight = {
                enable = true
            },
            -- enable indentation
            indent = {
                enable = true
            },
            ensure_installed = {
                "c_sharp",
                "lua",
                "javascript",
                "typescript",
                "tsx",
                "yaml",
                "html",
                "css",
                "git_config",
                "git_rebase",
                "gitattributes",
                "gitcommit",
                "json",
                "json5",
                "bash",
                "dockerfile",
                "gitignore",
                "vim",
                "vimdoc",
                "query",
                "markdown",
                "markdown_inline"
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-n>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
            textobjects = {
                select = {
                    enable = true,

                    -- Automatically jump forward to textobj, similar to targets.vim
                    lookahead = true,

                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        -- You can optionally set descriptions to the mappings (used in the desc parameter of
                        -- nvim_buf_set_keymap) which plugins like which-key display
                        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                        -- You can also use captures from other query groups like `locals.scm`
                        ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
                    },
                    -- You can choose the select mode (default is charwise 'v')
                    --
                    -- Can also be a function which gets passed a table with the keys
                    -- * query_string: eg '@function.inner'
                    -- * method: eg 'v' or 'o'
                    -- and should return the mode ('v', 'V', or '<c-v>') or a table
                    -- mapping query_strings to modes.
                    selection_modes = {
                        ['@parameter.outer'] = 'v', -- charwise
                        ['@function.outer'] = 'V', -- linewise
                        ['@class.outer'] = '<c-v>', -- blockwise
                    },
                    -- If you set this to `true` (default is `false`) then any textobject is
                    -- extended to include preceding or succeeding whitespace. Succeeding
                    -- whitespace has priority in order to act similarly to eg the built-in
                    -- `ap`.
                    --
                    -- Can also be a function which gets passed a table with the keys
                    -- * query_string: eg '@function.inner'
                    -- * selection_mode: eg 'v'
                    -- and should return true or false
                    include_surrounding_whitespace = true,
                },
            },
        })
    end,
}
