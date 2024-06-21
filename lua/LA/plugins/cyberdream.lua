return
{
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,

		config = function()
    require("cyberdream").setup({
						transparent = true ,
						italic_comments = true,
						hide_fillchars = true,
        colors = {
            -- For a list of colors see `lua/cyberdream/colours.lua`
            -- Example:
				    bg = "#ffffff",
    bgAlt = "#1e2124",
    bgHighlight = "#3c4048",
    fg = "#ffffff",
    grey = "#7b8496",
    blue = "#5ea1ff",
    green = "#5eff6c",
    cyan = "#5ef1ff",
    red = "#ff6e5e",
    yellow = "#f1ff5e",
    magenta = "#ff5ef1",
    pink = "#ff5ea0",
    orange = "#ffbd5e",
    purple = "#bd5eff",
		},
		})
vim.cmd("colorscheme cyberdream")

    -- Enable transparent background
    transparent = true

    -- Enable italics comments
    italic_comments = true

    -- Replace all fillchars with ' ' for the ultimate clean look
    hide_fillchars = true

    -- Modern borderless telescope theme
    borderless_telescope = true

    -- Set terminal colors used in `:terminal`
    terminal_colors = true

		theme = {
        variant = "light", -- use "light" for the light variant
        highlights = {
            -- Highlight groups to override, adding new groups is also possible
            -- See `:h highlight-groups` for a list of highlight groups or run `:hi` to see all groups and their current values

            -- Example:
            Comment = { fg = "#696969", bg = "NONE", italic = true },
            -- Complete list can be found in `lua/cyberdream/theme.lua`
        },

        -- Override a color entirely
        colors = {
            -- For a list of colors see `lua/cyberdream/colours.lua`
            -- Example:
            -- bg = "#000000",
            -- green = "#00ff00",
            -- magenta = "#ff00ff",
				    bg = "#ffffff",
    bgAlt = "#1e2124",
    bgHighlight = "#3c4048",
    fg = "#ffffff",
    grey = "#7b8496",
    blue = "#5ea1ff",
    green = "#5eff6c",
    cyan = "#5ef1ff",
    red = "#ff6e5e",
    yellow = "#f1ff5e",
    magenta = "#ff5ef1",
    pink = "#ff5ea0",
    orange = "#ffbd5e",
    purple = "#bd5eff",
				print("we should be here")
        },
				print("here we are")
}

  end,

				-- init = function ()
				-- 				print("working colorscheme")
      -- vim.cmd.colorscheme 'cyberdream',
    print("working colorscheme"),
				-- end
}
