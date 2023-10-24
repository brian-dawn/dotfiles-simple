local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Auto-install lazy.nvim if not present.
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'}, --
    {'williamboman/mason.nvim'}, --
    {'williamboman/mason-lspconfig.nvim'}, --
    {'neovim/nvim-lspconfig'}, --
    {'hrsh7th/cmp-nvim-lsp'}, --
    {'hrsh7th/nvim-cmp'}, --
    {'L3MON4D3/LuaSnip'}, --

    {'folke/tokyonight.nvim'}, --
    {'stevedylandev/flexoki-nvim', name = 'flexoki'}, --
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 }, --
    {'AstroNvim/astrotheme'}, --

    {'nvim-lualine/lualine.nvim'}, --
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.4',
        dependencies = {'nvim-lua/plenary.nvim'}
    }, --
    {'nvim-treesitter/nvim-treesitter'}, --
    {'tpope/vim-surround'}, --
    {'zbirenbaum/copilot.lua'}, --

    {'windwp/nvim-autopairs'}, --
    {'windwp/nvim-ts-autotag'}, --

    {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "nvim-telescope/telescope.nvim", -- optional
    "sindrets/diffview.nvim",        -- optional
    "ibhagwan/fzf-lua",              -- optional
  },
  config = true
}, -- Neogit

    {'phaazon/hop.nvim'}, --

    {'nvim-tree/nvim-tree.lua'}, --
    {'nvim-tree/nvim-web-devicons'}, --

    {'lewis6991/gitsigns.nvim'}, --
    {'pocco81/auto-save.nvim'}, --
    {
        'numToStr/Comment.nvim',
        opts = {
            -- add any options here
        },
        lazy = false,
    }, --
})

-- setup auto save
require('auto-save').setup()


require('astrotheme').setup()
require('catppuccin').setup({
    term_colors = true
})
vim.cmd.colorscheme "catppuccin"

require('lualine').setup({
    options = {
        section_separators = {'', ''}, -- removes separators
        component_separators = {'', ''} -- removes separators
    }
})


-- Tree sitter (used by some plugins e.g. html tag closing).
require'nvim-treesitter.configs'.setup {
    auto_install = true
}


require('nvim-tree').setup({
    update_focused_file = {
      enable = true,
    }
})
require('nvim-web-devicons').setup()
-- Disable the tree background color.
vim.api.nvim_exec([[
    hi NvimTreeNormal guibg=NONE
]], false)

-- LSP setup.
require('config-lsp')
require('config-copilot')

require('gitsigns').setup()

require('nvim-autopairs').setup()
require('nvim-ts-autotag').setup()

-- Set leader to space
vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', {noremap = true, silent = true})
vim.g.mapleader = ' '

-- Show numbers
vim.wo.number = true

-- Equivalent to 'set tabstop=4'
vim.opt.tabstop = 4

-- Equivalent to 'set shiftwidth=4'
vim.opt.shiftwidth = 4

-- Equivalent to 'set expandtab'
vim.opt.expandtab = true



-- Configure telescope.
require('config-telescope')

-- Enable gc
require('Comment').setup()


-- Terminal configuration
require('config-terminal')


require('hop').setup()
vim.keymap.set('n', '<leader>w', ":HopWord<cr>", { noremap = true, silent = true })

-- Clipboard configuration
vim.opt.clipboard:append { 'unnamed', 'unnamedplus' }


-- neovide
if vim.g.neovide then
  -- Enable copy paste on macos with cmd
  vim.keymap.set('n', '<D-s>', ':w<CR>') -- Save
  vim.keymap.set('v', '<D-c>', '"+y') -- Copy
  vim.keymap.set('n', '<D-v>', '"+P') -- Paste normal mode
  vim.keymap.set('v', '<D-v>', '"+P') -- Paste visual mode
  vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
  vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode

  vim.g.neovide_input_macos_alt_is_meta = true
  vim.g.neovide_cursor_trail_size = 0.0
  vim.g.neovide_scroll_animation_length = 0.005

  vim.g.neovide_cursor_animate_in_insert_mode = true
end
