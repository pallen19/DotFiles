 return
  -- This plugin is the undotree, it allow you to trace undo's even if you make another change within the history
  -- which would normally restart your undo history
  {
    'jiaoshijie/undotree',
    dependencies = 'nvim-lua/plenary.nvim',
    config = true,
    keys = { -- load the plugin only when using it's keybinding:
      { '<leader>u', "<cmd>lua require('undotree').toggle()<cr>" },
    },
  }
