return
{
	    "williamboman/mason.nvim",
    dependencies = {"williamboman/mason-lspconfig.nvim"},
    config = function()
	    local mason = require("mason")

	    -- import lsp config
	    local mason_lspconfig = require("mason-lspconfig")
mason.setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
}
})
mason_lspconfig.setup({

	ensured_installed = {'omnisharp','typescript-language-server','netcoredbg', 'yaml-language-server','lua-language-server', 'dockerfile-language-server','pyright'},
automatic_installation = true,
})
-- require("mason-lspconfig").setup({
-- 	ensured_installed = {'omnisharp','typescript-language-server','netcoredbg', 'yaml-language-server','lua-language-server', 'dockerfile-language-server'}
-- 	})

-- We want to return the mason plugin
-- and return a function that will require lspconfig plugin
	 -- require 'mason-lspconfig'.setup()
	 -- require 'lspconfig'.omnisharp.setup()
	 -- require 'neovim-lspconfig'.setup()
 end
}
