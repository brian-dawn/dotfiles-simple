require("gitsigns").setup({
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Navigation
		map("n", "]c", function()
			if vim.wo.diff then
				return "]c"
			end
			vim.schedule(function()
				gs.next_hunk()
			end)
			return "<Ignore>"
		end, { expr = true })

		map("n", "[c", function()
			if vim.wo.diff then
				return "[c"
			end
			vim.schedule(function()
				gs.prev_hunk()
			end)
			return "<Ignore>"
		end, { expr = true })

		-- Actions
		map("n", "<leader>ghs", gs.stage_hunk)
		map("n", "<leader>ghr", gs.reset_hunk)
		map("n", "<leader>ghS", gs.stage_buffer)
		map("n", "<leader>ghu", gs.undo_stage_hunk)
		map("n", "<leader>ghR", gs.reset_buffer)
		map("n", "<leader>ghb", function()
			gs.blame_line({ full = true })
		end)

		local which_key = require("which-key")
		which_key.register({
			["<leader>gh"] = {
				name = "+hunks",
				s = "Stage Hunk",
				r = "Reset Hunk",
				S = "Stage Buffer",
				u = "Undo Stage Hunk",
				R = "Reset Buffer",
				b = "Blame Line",
			},
			["]c"] = "Next Hunk",
			["[c"] = "Previous Hunk",
		})
	end,
})
