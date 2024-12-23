local M = {
    -- Maybe look into harpoon statusline if we use it more 
    'nvim-lualine/lualine.nvim',
    opts = {
        options = {
            theme = vim.g.colors_name,
            refresh = {
                statusline = 1000,
            },
        },
    }
}
return M
