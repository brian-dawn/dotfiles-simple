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
    {
        'numToStr/Comment.nvim',
        opts = {
            -- add any options here
        },
        lazy = false,
    }, --
})

-- Setup color theme.
vim.cmd [[colorscheme flexoki]]

require('lualine').setup({
    options = {
        section_separators = {'', ''}, -- removes separators
        component_separators = {'', ''} -- removes separators
    }
})

-- LSP setup.
local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws",
                   function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd",
                   function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end,
                   opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end,
                   opts)
    vim.keymap
        .set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end,
                   opts)
end)

-- Disable semantic tokens.
lsp_zero.set_server_config({
    on_init = function(client)
        client.server_capabilities.semanticTokensProvider = nil
    end
})

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {'tsserver', 'rust_analyzer'},
    handlers = {
        lsp_zero.default_setup,
        lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
        end
    }
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
    sources = {{name = 'path'}, {name = 'nvim_lsp'}, {name = 'nvim_lua'}},
    formatting = lsp_zero.cmp_format(),
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<tab>'] = cmp.mapping.confirm({select = true}),
        ['<enter>'] = cmp.mapping.confirm({select = true}),
        ['<C-Space>'] = cmp.mapping.complete()
    })
})


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


