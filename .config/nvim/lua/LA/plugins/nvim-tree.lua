return {
    'nvim-tree/nvim-tree.lua',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        --recommended settings from nvim-tree docs
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        require('nvim-tree').setup {
            view = {
                width = 50,
                relativenumber = true,
            },
            renderer = {
                indent_markers = {
                    enable = true,
                },
                icons = {
                    glyphs = {
                        folder = {
                            arrow_closed = '',
                            arrow_open = '',
                        },
                    },
                },
            },
            actions = {
                open_file = {
                    window_picker = {
                        enable = false,
                    },
                },
            },

            filters = {
                dotfiles = true,
                custom = { '.DS_Store' },
            },

            git = {
                ignore = false,
            },
        }

        local keymap = vim.keymap

        keymap.set('n', '<leader>fe', '<cmd>NvimTreeToggle<CR>', { desc = 'Toggle File Explorer' })
        keymap.set('n', '<leader>ff', '<cmd>NvimTreeFindFileToggle<CR>',
            { desc = 'Toggle File Explorer on current buffer' })
        keymap.set('n', '<leader>fc', '<cmd>NvimTreeCollapse<CR>', { desc = 'Collapse file explorer' })
        keymap.set('n', '<leader>fr', '<cmd>NvimTreeRefresh<CR>', { desc = 'Refresh file explorer' })
    end,
}
