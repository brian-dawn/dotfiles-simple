-- Formatted with stylua
-- https://github.com/JohnnyMorganz/StyLua
-- stylua .
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Auto-install lazy.nvim if not present.
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

	-- LSP setup.
	{ "nvim-treesitter/nvim-treesitter" },
	{ "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "neovim/nvim-lspconfig" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/nvim-cmp" },
	{ "L3MON4D3/LuaSnip" },

	-- Colorschemes.
	{ "folke/tokyonight.nvim" },
	{ "stevedylandev/flexoki-nvim", name = "flexoki" },
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{ "AstroNvim/astrotheme" },

	-- Adds indent guides.
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

	-- Hover terminals among other things.
	{ "akinsho/toggleterm.nvim", version = "*", config = true },

	-- Improved and auto formatting.
	{ "stevearc/conform.nvim" },

	-- Help menu to show keybindings.
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {},
	},

	-- Enhanced UI elements such as a better command bar,
	-- and better LSP help text as you type.
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			messages = {
				enabled = false,
			},
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
	},

	-- A nicer status line.
	{ "nvim-lualine/lualine.nvim" },

	-- Change surrounding characters.
	{ "tpope/vim-surround" },

	-- Github Copilot integration.
	{ "zbirenbaum/copilot.lua" },

	-- Auto guess indentation level from file.
	{ "NMAC427/guess-indent.nvim" },

	-- Treesitter auto pairs.
	{ "windwp/nvim-autopairs" },
	{ "windwp/nvim-ts-autotag" },

	-- Telescope fuzzy finder.
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"debugloop/telescope-undo.nvim",
		},
		config = function()
			require("telescope").setup({
				extensions = {
					undo = {

						side_by_side = true,
						layout_strategy = "vertical",
						layout_config = {
							preview_height = 0.8,
						},
					},
				},
			})
			require("telescope").load_extension("undo")
		end,
	},

	-- Show diagnostics in a nicer way.
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	},

	-- Git integration.
	{ "tpope/vim-fugitive" },

	-- Hop to word.
	{ "phaazon/hop.nvim" },

	-- File explorer.
	{ "nvim-tree/nvim-tree.lua" },
	{ "nvim-tree/nvim-web-devicons" },

	-- Git sigils in gutter.
	{ "lewis6991/gitsigns.nvim" },

	-- Auto save documents.
	{
		"zoriya/auto-save.nvim",
	},

	-- Comment out blocks of code.
	{
		"numToStr/Comment.nvim",
		opts = {},
		lazy = false,
	},
})

require("astrotheme").setup()
require("catppuccin").setup({
	term_colors = true,
})
vim.cmd.colorscheme("astromars")

require("lualine").setup({
	sections = {
		lualine_c = {
			{ "filename", path = 1 },
		},
	},
	options = {
		section_separators = { "", "" }, -- removes separators
		component_separators = { "", "" }, -- removes separators
		globalstatus = true,
	},
})

-- Tree sitter (used by some plugins e.g. html tag closing).
require("nvim-treesitter.configs").setup({
	auto_install = true,
})

require("nvim-tree").setup({
	update_focused_file = {
		enable = true,
	},
})
require("nvim-web-devicons").setup()

require("guess-indent").setup({
	auto_cmd = true,
})

-- LSP setup.
require("config-lsp")
require("config-copilot")

require("config-formatting")

require("gitsigns").setup()

require("nvim-autopairs").setup()
require("nvim-ts-autotag").setup()

-- Set leader to space
vim.api.nvim_set_keymap("n", "<Space>", "<NOP>", { noremap = true, silent = true })
vim.g.mapleader = " "

-- Show numbers
vim.wo.number = true

-- Equivalent to 'set tabstop=4'
vim.opt.tabstop = 4

-- Equivalent to 'set shiftwidth=4'
vim.opt.shiftwidth = 4

-- Equivalent to 'set expandtab'
vim.opt.expandtab = true

-- Configure telescope.
require("config-telescope")

-- Enable gc
require("Comment").setup()

require("ibl").setup({
	scope = {
		enabled = false, -- Disable scoped highlighting when treesitter is enabled, it's neat but annoying.
	},
})

-- Terminal configuration
require("config-terminal")

require("config-bindings")

require("hop").setup()

-- Clipboard configuration
vim.opt.clipboard:append({ "unnamed", "unnamedplus" })

vim.opt.wrap = false

require("show-help")

-- Set title.
vim.opt.title = true

-- Disable auto commenting new lines.
vim.cmd("autocmd BufEnter * set formatoptions-=cro")
vim.cmd("autocmd BufEnter * setlocal formatoptions-=cro")

-- Disable separators.
vim.opt.fillchars = { vert = " " }

-- neovide
if vim.g.neovide then
	-- Enable copy paste on macos with cmd
	vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
	vim.keymap.set("v", "<D-c>", '"+y') -- Copy
	vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
	vim.keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
	vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
	vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode

	vim.g.neovide_cursor_vfx_mode = ""
	vim.g.neovide_input_macos_alt_is_meta = true
	vim.g.neovide_cursor_trail_size = 0.0
	vim.g.neovide_scroll_animation_length = 0.005

	vim.g.neovide_cursor_animate_in_insert_mode = true
	vim.g.neovide_scale_factor = 1.0
	local change_scale_factor = function(delta)
		vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
	end
	vim.keymap.set("n", "<C-=>", function()
		change_scale_factor(1.25)
	end)
	vim.keymap.set("n", "<C-->", function()
		change_scale_factor(1 / 1.25)
	end)
end

-- wsl copy paste
if vim.fn.has("wsl") == 1 then
	vim.g.clipboard = {
		name = "WslClipboard",
		copy = {
			["+"] = "clip.exe",
			["*"] = "clip.exe",
		},
		paste = {
			["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
			["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
		},
		cache_enabled = 0,
	}
end
