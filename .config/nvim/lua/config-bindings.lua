vim.keymap.set("n", "<leader>xx", function()
	require("trouble").toggle()
end)
vim.keymap.set("n", "<leader>xw", function()
	require("trouble").toggle("workspace_diagnostics")
end)
vim.keymap.set("n", "<leader>xd", function()
	require("trouble").toggle("document_diagnostics")
end)
vim.keymap.set("n", "<leader>xq", function()
	require("trouble").toggle("quickfix")
end)
vim.keymap.set("n", "<leader>xl", function()
	require("trouble").toggle("loclist")
end)

vim.keymap.set("n", "<leader>w", ":HopWord<cr>", { noremap = true, silent = true })

-- When in visual mode, pressing J or K will move the selected lines down or up.
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

local which_key = require("which-key")
which_key.register({
	["<leader>x"] = {
		name = "+trouble",
		x = "Toggle Trouble",
		w = "Workspace Diagnostics",
		d = "Document Diagnostics",
		q = "Quickfix",
		l = "Loclist",
	},
	["<leader>w"] = "Hop to Word",
	["v"] = {
		name = "+visual",
		J = "Move lines down",
		K = "Move lines up",
	},
}, {})
