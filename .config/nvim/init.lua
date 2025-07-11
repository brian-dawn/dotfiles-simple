vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.autoread = true
vim.opt.clipboard = "unnamedplus"
vim.g.mapleader = " "

vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "FocusGained" }, {
  pattern = "*",
  command = "checktime"
})

vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
  pattern = "*",
  callback = function()
    if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
      vim.cmd("silent! write")
    end
  end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    vim.schedule(function()
      print("Lazy.nvim loaded successfully")
    end)
  end,
})

require("lazy").setup({
  {
    "amedoeyes/eyes.nvim",
    priority = 1000,
  },
  {
    "altercation/vim-colors-solarized",
    priority = 1000,
  },
  {
    "bettervim/yugen.nvim",
    priority = 1000,
  },
  {
    "ayu-theme/ayu-vim",
    priority = 1000,
  },
  {
    "thesimonho/kanagawa-paper.nvim",
    priority = 1000,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
  },
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
  },
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
  },
  {
    "jnurmine/Zenburn",
    priority = 1000,
  },
  {
    "sainnhe/gruvbox-material",
    priority = 1000,
  },
  {
    "webhooked/kanso.nvim",
    priority = 1000,
  },
  {
    "sainnhe/everforest",
    priority = 1000,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
  },
  {
    "shaunsingh/nord.nvim",
    priority = 1000,
  },
  {
    "kepano/flexoki-neovim",
    name = "flexoki",
    priority = 1000,
    config = function()
      vim.cmd("colorscheme flexoki-dark")
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup()
    end,
  },
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup({
        delay = 500,
      })
      
      require("which-key").add({
        { "<leader>f", desc = "Find files" },
        { "<leader>/", desc = "Global search" },
        { "<leader>b", desc = "Find buffers" },
        { "<leader>?", desc = "Find help" },
        { "<leader>.", desc = "Resume last search" },
        { "<leader>C", desc = "Choose colorscheme" },
        { "<leader>l", group = "LSP" },
        { "<leader>la", desc = "Code actions" },
        { "<leader>lr", desc = "Rename" },
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")
      
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'path' },
        })
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      capabilities.textDocument.semanticTokens = {
        dynamicRegistration = false,
        tokenTypes = {
          "namespace", "type", "class", "enum", "interface", "struct",
          "typeParameter", "parameter", "variable", "property", "enumMember",
          "event", "function", "method", "macro", "keyword", "modifier",
          "comment", "string", "number", "regexp", "operator", "decorator"
        },
        tokenModifiers = {
          "declaration", "definition", "readonly", "static", "deprecated",
          "abstract", "async", "modification", "documentation", "defaultLibrary"
        },
        formats = {"relative"}
      }
      
      require("mason-lspconfig").setup({
        automatic_installation = true,
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({
              capabilities = capabilities,
              on_attach = function(client, bufnr)
                if client.server_capabilities.semanticTokensProvider then
                  vim.lsp.semantic_tokens.start(bufnr, client.id)
                end
              end,
            })
          end,
        }
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim", "hrsh7th/cmp-nvim-lsp" },
    config = function()
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
      vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code action" })
      vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename" })
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          layout_strategy = "horizontal",
          layout_config = {
            preview_width = 0.6,
          },
        },
        pickers = {
          colorscheme = {
            enable_preview = true,
          },
        },
      })
      
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Global search" })
      vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Find buffers" })
      vim.keymap.set("n", "<leader>?", builtin.help_tags, { desc = "Find help" })
      vim.keymap.set("n", "<leader>.", builtin.resume, { desc = "Resume last search" })
      vim.keymap.set("n", "<leader>C", function() 
        builtin.colorscheme({ enable_preview = true })
      end, { desc = "Choose colorscheme" })
    end,
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
      
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua",
          "vim",
          "go",
          "gomod",
          "gowork",
          "gosum",
          "zig",
          "python",
          "typescript",
          "javascript",
          "rust",
          "toml",
          "json",
          "jsonc",
        },
        highlight = {
          enable = true,
        },
        auto_install = true,
      })
    end,
  },
})



