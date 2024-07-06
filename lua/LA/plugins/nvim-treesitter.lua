return{
'nvim-treesitter/nvim-treesitter',
build = ":TSUpdate",
event = {"BufReadPre", "BufNewFile"},
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
												 node_incremental = "<C-space>",
												 scope_incremental = false,
												 node_decremental = "<bs>",
								 },
				 },
})
end,
}
