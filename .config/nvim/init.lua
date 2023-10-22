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
    {'folke/tokyonight.nvim'}, --
    {'stevedylandev/flexoki-nvim', name = 'flexoki'}, --
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


-- Setup color theme.
vim.cmd [[colorscheme flexoki]]

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


require('nvim-tree').setup()
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


-- Telescope (fuzzy search) setup
-- TODO: Check out the other options and add LSP.
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})


-- Enable gc
require('Comment').setup()


-- Terminal configuration
require('config-terminal')


require('hop').setup()
vim.keymap.set('n', '<leader>w', ":HopWord<cr>", { noremap = true, silent = true })

-- Clipboard configuration
-- vim.opt.clipboard = "unnamedplus"

