return
{
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,

		config = function()
    require("cyberdream").setup({
						transparent = false ,
						italic_comments = true,
						hide_fillchars = true,
						borderless_telescope =true,
						terminal_colors = true
		})
vim.cmd("colorscheme cyberdream")

				-- print("default theme is above")

				theme = {
								variant = "light",
								colors = {},
								highlights = {},
				}

  end,


    -- print("working colorscheme"),
				-- end
}
