-- Formatted with stylua
-- https://github.com/JohnnyMorganz/StyLua
-- stylua .

---------------------------------------------------------
-- Useful commands that aren't always mapped to stuff.
---------------------------------------------------------
-- :Telescope colorscheme
--    Live change colorschemes with previews.

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
	{ "SmiteshP/nvim-navic" },

	-- Code status line (what method are you in at the top).
	--{ "numToStr/Navigator.nvim" },
	{ 'mrjones2014/smart-splits.nvim' },

	-- Colorschemes.
	{ "folke/tokyonight.nvim" },
	{ "stevedylandev/flexoki-nvim", name = "flexoki" },
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{ "AstroNvim/astrotheme" },
	{ "rose-pine/neovim", name = "rose-pine" },
	{ "ellisonleao/gruvbox.nvim", priority = 1000, config = true, opts = {} },
	{ "navarasu/onedark.nvim" },
	{ "phha/zenburn.nvim" },
	{ "theacodes/witchhazel" },
	{ "rebelot/kanagawa.nvim" },

	-- Wezterm Integrations
	{ 'mrjones2014/smart-splits.nvim' },

	-- Adds indent guides.
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

	-- Hover terminals among other things.
	{ "akinsho/toggleterm.nvim", version = "*", opts = {
		shade_terminals = false,
		direction = 'horizontal',
    	open_mapping = [[<c-`>]],
    	hide_numbers = true,
    	auto_scroll = true,
		size = 30
	} },

	-- Improved and auto formatting.
	{ "stevearc/conform.nvim" },

	-- Help menu to show keybindings.
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 1300
		end,
		opts = {
			notify = false
		},
	},

	-- Show signature of function as you type.
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {},
		config = function(_, opts)
			require("lsp_signature").setup(opts)
		end,
	},

	-- Show progress of LSP.
	{
		"linrongbin16/lsp-progress.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lsp-progress").setup()
		end,
	},

	-- A nicer status line.
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"linrongbin16/lsp-progress.nvim",
		},
	},

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
				pickers = {
					colorscheme = {
						enable_preview = true,
					},
				},
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
			require("telescope").load_extension("aerial")
		end,
	},

	-- Navigate code at a high level
	{
		"stevearc/aerial.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},

	-- Git integration.
	{ "tpope/vim-fugitive" },

	-- Hop to word.
	{ "phaazon/hop.nvim" },

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
	},

	-- Git sigils in gutter.
	{ "lewis6991/gitsigns.nvim" },
})

require("lsp_signature").setup({
	hint_enable = false,
})

require("astrotheme").setup()
require("catppuccin").setup({
	term_colors = true,
})
vim.cmd.colorscheme("catppuccin")

require("config-lualine")

-- Tree sitter (used by some plugins e.g. html tag closing).
require("nvim-treesitter.configs").setup({
	auto_install = true,
	highlight = {
		enable = true, -- false will disable the whole extension
		additional_vim_regex_highlighting = false,
	},
	ensure_installed = {
		"astro",
		"bash",
		"go",
		"css",
		"html",
		"javascript",
		"json",
		"lua",
		"python",
		"rust",
		"toml",
		"tsx",
		"typescript",
		"yaml",
		"svelte",
		"ocaml",
	},
})

require("neo-tree").setup({
	close_if_last_window = true,
	filesystem = {
		follow_current_file = {
			enabled = true,
		},
	},
	source_selector = {
		statusline = false,
		winbar = true,
		sources = {
			{ source = "filesystem" },
			{ source = "buffers" },
			{ source = "git_status" },
			{ source = "document_symbols" },
		},
	},
	sources = { "filesystem", "buffers", "git_status", "document_symbols" },
})
require("nvim-web-devicons").setup()

require("guess-indent").setup({
	auto_cmd = true,
})

-- LSP setup.
require("config-lsp")
require("config-copilot")

require("config-formatting")
require("config-git")

require("nvim-autopairs").setup()
require("nvim-ts-autotag").setup()

-- Set leader to space
vim.api.nvim_set_keymap("n", "<Space>", "<NOP>", { noremap = true, silent = true })
vim.g.mapleader = " "

-- Show numbers
vim.wo.number = true

-- Equivalent to 'set tabstop=4'
vim.opt.tabstop = 4

-- Set tab to be 4 spaces.
vim.opt.softtabstop = 4

-- Equivalent to 'set shiftwidth=4'
vim.opt.shiftwidth = 4

-- Equivalent to 'set expandtab'
vim.opt.expandtab = true

-- Always have 8 characters of context around the cursor
vim.opt.scrolloff = 8

vim.opt.swapfile = false
vim.opt.backup = false

-- Use relative line numbers to make jumping around faster.
vim.wo.relativenumber = true

-- Disable the mode line via noshowmode
vim.opt.showmode = false

-- Configure telescope.
require("config-telescope")

require("ibl").setup({
	-- Change the ibl indent character to a skinnier bar.
	indent = {
		char = "│",
	},
	scope = {
		enabled = false, -- Disable scoped highlighting when treesitter is enabled, it's neat but annoying.
	},
})

-- Terminal configuration
require("config-terminal")

require("config-bindings")

require("hop").setup()

vim.opt.wrap = false

require("show-help")

-- Set title.
vim.opt.title = true

-- Disable auto commenting new lines.
vim.cmd("autocmd BufEnter * set formatoptions-=cro")
vim.cmd("autocmd BufEnter * setlocal formatoptions-=cro")

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
    vim.g.neovide_input_macos_option_key_is_meta = "only_left"
	vim.g.neovide_cursor_trail_size = 0.0
	vim.g.neovide_scroll_animation_length = 0

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

-- Auto save on focus lost.
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
	callback = function()
		if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
			vim.api.nvim_command("silent update")
		end
	end,
})
