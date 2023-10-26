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
    sources = {

        { name = "nvim_lsp",
            entry_filter = function(entry, ctx)
                -- Filter out snippets, even ones provided by the LSP.
                return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind()
            end },
    },

    -- Select the first item in the completion menu by default.
    preselect = 'item',
    completion = {
      completeopt = 'menu,menuone,noinsert'
    },
    -- 

    formatting = lsp_zero.cmp_format(),
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<tab>'] = cmp.mapping.confirm({select = true}),
        ['<enter>'] = cmp.mapping.confirm({select = true}),
        ['<C-Space>'] = cmp.mapping.complete()
    })
})

-- Sort warnings by severity.
vim.diagnostic.config({
  virtual_text = {
    severity_sort = true,
    prefix = '●', -- Could be '' or any other symbol you prefer
  },
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = true,
})


