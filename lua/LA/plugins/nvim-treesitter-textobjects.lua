return {
"nvim-treesitter/nvim-treesitter-textobjects",
lazy = true,
config = function()
require 'nvim-treesitter.configs'.setup({
textobjects = {
				select = {
								enable = true,

								--automatically jump forward to text objects, similar to targets.vim
								 lookahead = true,

								 keymaps = {
									-- You can use capture groups defined in textobjects.scm
									-- THESE ASSIGNMENTS ARENT SUPPORTED IN C_SHARP REMOVE WHEN TIME IS ALLOTTED
									["a="] = { query = "@assignment.outer", desc = "Select outer part of the assignment"},
									["i="] = { query = "@assignment.inner", desc = "Select inner part of the assignment"},
									["l="] = { query = "@assignment.lhs", desc = "Select left hand side of the assignment"},
									["r="] = { query = "@assignment.rhs", desc = "Select right hand side of the assignment"},
								 },
								},
				},
				})
end,
}
-- This file is currently not working as expected
