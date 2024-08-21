return {
"hrsh7th/nvim-cmp",
event = "InsertEnter",
dependencies = {
	"hrsh7th/cmp-buffer", -- source for text in the buffer
	"hrsh7th/cmp-nvim-lua", -- special nvim knowldege
	"hrsh7th/cmp-path", -- source for file system paths
	"hrsh7th/cmp-nvim-lsp", -- source for file system paths
	"L3MON4D3/LuaSnip",
	"saadparwaiz1/cmp_luasnip", --snippet engine
	"rafamadriz/friendly-snippets" -- useful snippets
},
config = function()
	local cmp = require("cmp")
	local luasnip = require("luasnip")

	require("luasnip.loaders.from_vscode").lazy_load()

	cmp.setup({
		completion = {
		completeopt= "menu,menuone,preview,noselect",
		},
		snippet = { --configure how cmp works with snippet engine
			expand = function(args)
				luasnip.lsp_expand(args.body)
				end,
			},

mapping = cmp.mapping.preset.insert({
	["<C-k>"] = cmp.mapping.select_prev_item(), --previous selection
	["<C-j>"] = cmp.mapping.select_next_item(), --next selection
	["<C-b>"] = cmp.mapping.scroll_docs(-4),
	["<C-f>"] = cmp.mapping.scroll_docs(4),
	["<C-Space>"] = cmp.mapping.complete(),
	["<C-e>"] = cmp.mapping.abort(),
	["<CR>"] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Insert, select=true}),

}),

--sources for autocompletion
sources = cmp.config.sources({
	{ name = "nvim_lua" },
	{ name = "nvim_lsp" },
	{ name = "luasnip" },
	{ name = "buffer", keyword_length = 5 },
	{ name = "path" },
}),
	})
end,
}

