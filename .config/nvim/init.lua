vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.autoread = true
vim.opt.clipboard = "unnamedplus"
vim.opt.scrolloff = 5
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

local gh = function(x) return "https://github.com/" .. x end

-- treesitter build hook
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name == "nvim-treesitter" and (ev.data.kind == "install" or ev.data.kind == "update") then
      vim.cmd("TSUpdate")
    end
  end,
})

vim.pack.add({
  -- colorschemes
  gh("amedoeyes/eyes.nvim"),
  gh("maxmx03/solarized.nvim"),
  gh("bettervim/yugen.nvim"),
  gh("ayu-theme/ayu-vim"),
  gh("thesimonho/kanagawa-paper.nvim"),
  { src = gh("catppuccin/nvim"), name = "catppuccin" },
  gh("rebelot/kanagawa.nvim"),
  gh("phha/zenburn.nvim"),
  gh("sainnhe/gruvbox-material"),
  gh("webhooked/kanso.nvim"),
  gh("sainnhe/everforest"),
  { src = gh("rose-pine/neovim"), name = "rose-pine" },
  gh("shaunsingh/nord.nvim"),
  gh("AlexvZyl/nordic.nvim"),
  gh("ellisonleao/gruvbox.nvim"),
  { src = gh("kepano/flexoki-neovim"), name = "flexoki" },

  -- mini.nvim
  gh("echasnovski/mini.nvim"),

  -- treesitter
  gh("nvim-treesitter/nvim-treesitter"),

  -- git
  gh("lewis6991/gitsigns.nvim"),
  gh("nvim-lua/plenary.nvim"),
  gh("sindrets/diffview.nvim"),
  gh("NeogitOrg/neogit"),

  -- misc
  gh("catgoose/nvim-colorizer.lua"),
})

-- colorscheme
vim.cmd("colorscheme gruvbox")

-- mini.nvim
require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons()

require("mini.pick").setup({
  window = {
    config = function()
      local height = math.floor(0.618 * vim.o.lines)
      local width = math.floor(0.618 * vim.o.columns)
      return {
        anchor = "NW",
        height = height,
        width = width,
        row = math.floor(0.5 * (vim.o.lines - height)),
        col = math.floor(0.5 * (vim.o.columns - width)),
      }
    end,
  },
})

require("mini.clue").setup({
  triggers = {
    { mode = "n", keys = "<Leader>" },
    { mode = "x", keys = "<Leader>" },
    { mode = "n", keys = "g" },
    { mode = "x", keys = "g" },
    { mode = "n", keys = "'" },
    { mode = "n", keys = "`" },
    { mode = "x", keys = "'" },
    { mode = "x", keys = "`" },
    { mode = "n", keys = '"' },
    { mode = "x", keys = '"' },
    { mode = "i", keys = "<C-r>" },
    { mode = "c", keys = "<C-r>" },
    { mode = "n", keys = "<C-w>" },
    { mode = "n", keys = "z" },
    { mode = "x", keys = "z" },
    { mode = "n", keys = "]" },
    { mode = "n", keys = "[" },
  },
  clues = {
    require("mini.clue").gen_clues.builtin_completion(),
    require("mini.clue").gen_clues.g(),
    require("mini.clue").gen_clues.marks(),
    require("mini.clue").gen_clues.registers(),
    require("mini.clue").gen_clues.windows(),
    require("mini.clue").gen_clues.z(),
    { mode = "n", keys = "<Leader>g", desc = "+Git" },
  },
  window = {
    delay = 300,
  },
})

vim.keymap.set("n", "<leader>f", "<cmd>Pick files<cr>", { desc = "Find files" })
vim.keymap.set("n", "<leader>/", "<cmd>Pick grep_live<cr>", { desc = "Grep" })
vim.keymap.set("n", "<leader>b", "<cmd>Pick buffers<cr>", { desc = "Buffers" })
vim.keymap.set("n", "<leader>?", "<cmd>Pick help<cr>", { desc = "Help" })
vim.keymap.set("n", "<leader>.", "<cmd>Pick resume<cr>", { desc = "Resume" })

vim.keymap.set("n", "<leader>T", function()
  if vim.o.background == "dark" then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end
end, { desc = "Toggle light/dark" })

-- treesitter (highlight/indent are now builtin, plugin installs parsers + queries)
local ts_parsers = {
  "lua", "vim", "vimdoc", "go", "gomod", "gowork", "gosum",
  "zig", "python", "typescript", "javascript", "tsx",
  "rust", "toml", "json", "yaml", "html", "css",
  "bash", "markdown", "markdown_inline", "regex", "query",
}

require("nvim-treesitter").install(ts_parsers)

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    if pcall(vim.treesitter.start) then
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

-- gitsigns
require("gitsigns").setup({
  current_line_blame = true,
  current_line_blame_opts = { delay = 300 },
})
vim.keymap.set("n", "<leader>gB", "<cmd>Gitsigns blame_line<cr>", { desc = "Git blame" })
vim.keymap.set("n", "<leader>gh", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Preview hunk" })
vim.keymap.set("n", "<leader>gH", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Reset hunk" })
vim.keymap.set("n", "]h", "<cmd>Gitsigns next_hunk<cr>", { desc = "Next hunk" })
vim.keymap.set("n", "[h", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Previous hunk" })

-- neogit
require("neogit").setup()
vim.keymap.set("n", "<leader>gs", "<cmd>Neogit<cr>", { desc = "Git status" })
vim.keymap.set("n", "<leader>gc", "<cmd>Neogit commit<cr>", { desc = "Git commit" })
vim.keymap.set("n", "<leader>gp", "<cmd>Neogit push<cr>", { desc = "Git push" })
vim.keymap.set("n", "<leader>gl", "<cmd>Neogit log<cr>", { desc = "Git log" })
vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Git diff" })
vim.keymap.set("n", "<leader>gb", "<cmd>Neogit branch<cr>", { desc = "Git branch" })

-- colorizer
require("colorizer").setup()

local function set_theme()
  local handle = io.popen("dark-notify -e")
  local result = handle:read("*a")
  handle:close()
  
  if result:match("dark") then
    vim.o.background = "dark"
  else
    vim.o.background = "light"
  end
end

set_theme()

vim.fn.jobstart("dark-notify", {
  stdout_buffered = false,
  on_stdout = function(_, data)
    if data then
      for _, line in ipairs(data) do
        if line == "dark" then
          vim.schedule(function()
            vim.o.background = "dark"
          end)
        elseif line == "light" then
          vim.schedule(function()
            vim.o.background = "light"
          end)
        end
      end
    end
  end,
})

