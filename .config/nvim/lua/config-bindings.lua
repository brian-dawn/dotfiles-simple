vim.keymap.set("n", "<leader>w", ":HopWord<cr>", { noremap = true, silent = true })

-- When in visual mode, pressing J or K will move the selected lines down or up.
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Yank to the system keyboard.
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')
vim.keymap.set("v", "<leader>Y", '"+Y')

-- paste from the system keyboard.
vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("v", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>P", '"+P')

vim.keymap.set("n", "<leader>va", ":Telescope aerial<CR>")

vim.keymap.set('n', '<A-h>', require('smart-splits').move_cursor_left)
vim.keymap.set('n', '<A-j>', require('smart-splits').move_cursor_down)
vim.keymap.set('n', '<A-k>', require('smart-splits').move_cursor_up)
vim.keymap.set('n', '<A-l>', require('smart-splits').move_cursor_right)

local which_key = require("which-key")
which_key.register({
	["<leader>w"] = "Hop to Word",
	["<leader>y"] = "Yank to system clipboard",
	["<leader>Y"] = "Yank to system clipboard (whole line)",
	["<leader>p"] = "Paste from system clipboard",
	["<leader>P"] = "Paste from system clipboard",
	["<leader>va"] = "Navigate code",
}, {})

which_key.register({
	["<leader>y"] = "Yank to system clipboard",
	["<leader>Y"] = "Yank to system clipboard (whole line)",
	["<leader>p"] = "Paste from system clipboard",
}, { mode = "v" })
