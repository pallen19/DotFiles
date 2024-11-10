require 'LA.core.options'
require 'LA.core.keymaps'
require 'LA.plugins'

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- The event data property will contain a string with either "default" or "light" respectively
--[[ vim.api.nvim_create_autocmd('User', {
  pattern = 'CyberdreamToggleMode',
  callback = function(event)
    -- Your custom code here!
    -- For example, notify the user that the colorscheme has been toggled
    print('Switched to ' .. event.data .. ' mode!')

  end,
}) ]]
