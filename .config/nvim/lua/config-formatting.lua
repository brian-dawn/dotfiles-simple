require("conform").setup({

	formatters_by_ft = {
		lua = { "stylua" },

		-- Conform will run multiple formatters sequentially
		python = { "black" },
		-- Use a sub-list to run only the first available formatter
		javascript = { { "prettierd", "prettier" } },
		typescript = { { "prettierd", "prettier" } },
		javascriptreact = { { "prettierd", "prettier" } },
		typescriptreact = { { "prettierd", "prettier" } },
		html = { { "prettierd", "prettier" } },
		json = { { "prettierd", "prettier" } },
		ocaml = { "ocamlformat" },
		rust = { "custom_rust_fmt" },
		go = { "gofmt" },
	},
	formatters = {

		custom_rust_fmt = {

			command = "rustfmt",
			args = { "--emit=stdout", "--edition", "2021" },
			stdin = true,
		},
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
       pattern = "*",
       callback = function(args)
               require("conform").format({ bufnr = args.buf })
       end,
})
