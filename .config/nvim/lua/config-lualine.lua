require("lualine").setup({
	sections = {
		lualine_c = {
			require("lsp-progress").progress,
			{ "filename", path = 1 },
			{ "navic" },
		},
	},
	options = {
		section_separators = { "", "" }, -- removes separators
		component_separators = { "", "" }, -- removes separators
		globalstatus = true,
	},
})

-- Listen lsp-progress event and refresh lualine
vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
vim.api.nvim_create_autocmd("User", {
	group = "lualine_augroup",
	pattern = "LspProgressStatusUpdated",
	callback = require("lualine").refresh,
})
