-- Telescope (fuzzy search) setup

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>fm", builtin.marks, {})
vim.keymap.set("n", "<leader>r", builtin.resume, {})

vim.keymap.set("n", "<leader>gs", ":Telescope git_status<CR>", opts)
vim.keymap.set("n", "<leader>gc", ":Telescope git_commits<CR>", opts)
vim.keymap.set("n", "<leader>gb", ":Telescope git_branches<CR>", opts)
-- vim.keymap.set("n", "<leader>gc", ":Telescope git_bcommits<CR>", opts)

-- Also add find_files as ctrl + p
vim.keymap.set("n", "<C-p>", builtin.find_files, {})

-- When viewing the undo history you can press <C-enter> or <C-r> to go back to that state.
-- You can also just press enter to yank the additions to the current buffer.
vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")

local which_key = require("which-key")
which_key.register({
	["<leader>r"] = "Resume last telescope",
	["<leader>f"] = {
		name = "+find",
		f = "Find files",
		g = "Live grep",
		b = "Buffers",
		h = "Help tags",
		m = "Marks",
	},
	["<leader>g"] = {
		name = "+git",
		s = "Git status",
		c = "Git commits",
		b = "Git branches",
	},
	["<leader>u"] = "Undo",
	["<C-p>"] = "Find files",
}, {})
