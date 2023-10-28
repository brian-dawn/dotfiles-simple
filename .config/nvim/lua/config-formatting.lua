require("conform").setup({

	formatters_by_ft = {
		lua = { "stylua" },

		-- Conform will run multiple formatters sequentially
		python = { "isort", "black" },
		-- Use a sub-list to run only the first available formatter
		javascript = { { "prettierd", "prettier" } },
		typescript = { { "prettierd", "prettier" } },
		html = { { "prettierd", "prettier" } },
		json = { { "prettierd", "prettier" } },
		rust = { "rustfmt" },
		ocaml = { "ocamlformat" },
	},
})

_G.auto_save_running = false

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		-- Don't format on autosave.
		if _G.auto_save_running then
			return
		end

		require("conform").format({ bufnr = args.buf })
	end,
})

-- setup auto save
require("auto-save").setup({

	debounce_delay = 1000,
	callbacks = {
		before_saving = function()
			-- this is needed because auto-save is not working with conform
			-- set a global variable to check if auto-save is running
			_G.auto_save_running = true
		end,
		after_saving = function()
			--
			_G.auto_save_running = false
		end,
	},
})
