local Mod = {
  -- Use `opts = {}` to force a plugin to be loaded.
  --
  --  This is equivalent to:
  --    require('Comment').setup({})

  -- "gc" to comment visual regions/lines
  -- "gcc" to comment line
  -- "gb" to comment block visual regions/lines
  -- "gcb" to comment block

   'numToStr/Comment.nvim', opts = {}
}

return Mod

