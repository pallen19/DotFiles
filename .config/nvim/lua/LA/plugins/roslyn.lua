return {
    "seblj/roslyn.nvim",
    ft = "cs",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        config = {
            settings = {
                ["csharp|inlay_hints"] = {
                    csharp_enable_inlay_hints_for_implicit_object_creation = true,
                    csharp_enable_inlay_hints_for_implicit_variable_types = true,
                    csharp_enable_inlay_hints_for_lambda_parameter_types = true,
                    csharp_enable_inlay_hints_for_types = true,
                    dotnet_enable_inlay_hints_for_indexer_parameters = true,
                    dotnet_enable_inlay_hints_for_literal_parameters = true,
                    dotnet_enable_inlay_hints_for_object_creation_parameters = true,
                    dotnet_enable_inlay_hints_for_other_parameters = true,
                    dotnet_enable_inlay_hints_for_parameters = true,
                    dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
                    dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
                    dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
                },
                ["csharp|code_lens"] = {
                    dotnet_enable_references_code_lens = true,
                },
                ["csharp|completion"] = {
                    dotnet_provide_regex_completions = true,
                    dotnet_show_completion_items_from_unimported_namespaces = true,
                    dotnet_show_name_completion_suggestions = true
                }
            },
            vim.lsp.inlay_hint.enable(),
        },
    },


    keys = {
        { '<leader>gd', vim.lsp.buf.definition,              { noremap = false, silent = true, desc = 'Go To Definiton' } },
        { '<leader>gi', vim.lsp.buf.implementation,          { noremap = false, silent = true, desc = 'Go To Implementation' } },
        { '<leader>ca', vim.lsp.buf.code_action,             { noremap = false, silent = true, desc = 'Code Action' } },
        { '<leader>gr', '<cmd>Telescope lsp_references<cr>', { noremap = false, silent = true, desc = 'Code References' } },
        { '<leader>rn', vim.lsp.buf.rename,                  { noremap = false, silent = true, desc = 'Rename' } },
        { '<leader>rs', '<cmd>Roslyn restart<cr>',           { noremap = false, silent = true, desc = 'Restart Roslyn Lsp Server' } },
        { "<leader>fm", vim.lsp.buf.format,                  { noremap = false, silent = true, desc = 'Format Current Buffer' } },
        { "K", vim.lsp.buf.hover, { noremap = false, silent = true, desc = 'Hover Help' }
        },
    }
}
