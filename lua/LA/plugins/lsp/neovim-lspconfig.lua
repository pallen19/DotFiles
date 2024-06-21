return{
  "neovim/nvim-lspconfig",
 event = {"BufReadPre","BufNewFile"},
 dependencies = {
    "hrsh7th/cmp-nvim-lsp", --completion source 
    {"antosha417/nvim-lsp-file-operations", config = true }, --rename files through nvim tree and update imports
    },
    config = function()
     -- import lspconfig plugin
      local lspconfig = require("lspconfig")

      -- import cmp-nvim-lsp plugin
      local cmp_nvim_lsp = require("cmp_nvim_lsp")

      local keymap = vim.keymap
      local opts = {noremap = false , silent = true }
      local on_attach = function(client, bufnr)
	      opts.buffer = bufnr

	      --set keybindings
	      opts.desc = "Show LSP reference"
	      keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

	      opts.desc = "Go to declarations"
	      keymap.set("n", "gD", vim.lsp.buf.declarations, opts)

	      opts.desc = "Show LSP definitions"
	      keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

	      opts.desc = "Show LSP implementations"
	      keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

	      opts.desc = "Show LSP type definitions"
	      keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

	      opts.desc = "See available [C]ode [A]ctions"
	      keymap.set("n", "ca", vim.lsp.buf.code_action, opts)

	      opts.desc = "Smart Rename"
	      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

	      opts.desc = "Show Buffer Diagnostics"
	      keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

	      opts.desc = "Go to previous Diagnostic"
	      keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

	      opts.desc = "Go to next Diagnostic"
	      keymap.set("n", "]d", vim.diagnostics.goto_next, opts)

	      opts.desc = "Show Documentation under Cursor"
	      keymap.set("n", "K", vim.lsp.buf.hover, opts)

	      opts.desc = "Restart LSP"
	      keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
	end

	--used to enable autocompletion
	local capabilities = cmp_nvim_lsp.default_capabilities()

	local signs = {Error = '', Warn = '', Hint = '' , Info = '' }
	for type, icon in pairs(signs) do
		local hl ="DiagnoticSign" .. type
		vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl= ""})
	end

	-- configure c sharp server
	-- lspconfig["omnisharp"].setup({
 --  	  capabilities = capabilities,
	--   on_attach = on_attach,
 --    file_types= { "cs" },
	-- })
	lspconfig["docker_compose_language_service"].setup({
  	  capabilities = capabilities,
	  file_types = {"docker-compose.yaml","docker-compose.yml"},
	  on_attach = on_attach,
	})

	lspconfig["csharp_ls"].setup({
  	  capabilities = capabilities,
	  on_attach = on_attach,
    file_types= { "cs" },
	})

	lspconfig["lua_ls"].setup({
  	  capabilities = capabilities,
	  file_types = {"lua"},
	  on_attach = on_attach,
	  settings = {
	    Lua = {
	    -- make the language server recognize vim global
	    diagnostics = {
		globals = {"vim"},
	    },
	    workspace = {
	    -- make language server aware of runtime files
	      library = {
		[vim.fn.expand("$VIMRUNTIME/lua")] = true,
		[vim.fn.stdpath("config").. "/lua"] = true,
	      },
	    },
	   },
	  },
	})
     end,

}
