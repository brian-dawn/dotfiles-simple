local lsp_zero = require("lsp-zero")
local which_key = require("which-key")

lsp_zero.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, opts)
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, opts)
	vim.keymap.set("n", "<leader>vco", ":Telescope lsp_outgoing_calls<CR>", opts)
	vim.keymap.set("n", "<leader>vci", ":Telescope lsp_incoming_calls<CR>", opts)
	vim.keymap.set("n", "<leader>vws", ":Telescope lsp_workspace_symbols<CR>", opts)
	vim.keymap.set("n", "<leader>vd", function()
		vim.diagnostic.open_float()
	end, opts)
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.goto_next()
	end, opts)
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.goto_prev()
	end, opts)
	vim.keymap.set("n", "<leader>vca", function()
		vim.lsp.buf.code_action()
	end, opts)
	vim.keymap.set("n", "<leader>vrr", ":Telescope lsp_references<CR>", opts)
	vim.keymap.set("n", "<leader>vrn", function()
		vim.lsp.buf.rename()
	end, opts)
	vim.keymap.set("i", "<C-h>", function()
		vim.lsp.buf.signature_help()
	end, opts)

	which_key.register({
		-- Normal mode
		g = {
			name = "Go to",
			d = "Go to definition",
		},
		K = "Show hover",
		["<leader>v"] = {
			name = "lsp",
			c = {
				name = "Code",
				o = "Outgoing calls",
				i = "Incoming calls",
				a = "Code action",
			},
			d = "Diagnostics float",
			w = {
				name = "Workspace",
				s = "Workspace symbols",
			},
			r = {
				name = "References/Rename",
				r = "References",
				n = "Rename",
			},
		},
		["[d"] = "Next diagnostic",
		["]d"] = "Previous diagnostic",
	}, { buffer = bufnr })
end)

require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = { "tsserver", "rust_analyzer" },
	handlers = {
		lsp_zero.default_setup,
		lua_ls = function()
			local lua_opts = lsp_zero.nvim_lua_ls()
			require("lspconfig").lua_ls.setup(lua_opts)
		end,
	},
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
	sources = {

		{
			name = "nvim_lsp",
			entry_filter = function(entry, ctx)
				-- Filter out snippets, even ones provided by the LSP.
				return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind()
			end,
		},
	},

	formatting = lsp_zero.cmp_format(),
	mapping = cmp.mapping.preset.insert({
		["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
		["<tab>"] = cmp.mapping.confirm({ select = true }),
		["<enter>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
	}),
})

-- Sort warnings by severity.
vim.diagnostic.config({
	virtual_text = {
		severity_sort = true,
		prefix = "●", -- Could be '' or any other symbol you prefer
	},
	signs = true,
	underline = true,
	-- update_in_insert = true,
	severity_sort = true,
})

local nvim_lsp = require("lspconfig")

nvim_lsp.rust_analyzer.setup({
	settings = {
		["rust-analyzer"] = {
			-- Enable procedural macro expansion
			procMacro = {
				enable = true,
			},
		},
	},
})
