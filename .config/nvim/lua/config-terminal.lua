vim.keymap.set("t", "<esc>", "<C-\\><C-n>") -- esc to exit insert

vim.api.nvim_create_autocmd({"BufWinEnter", "TermOpen"}, {
    pattern = "term://*toggleterm#*",
    callback = function()
        if vim.o.filetype == "toggleterm" then
            vim.cmd("startinsert!")
        end
    end,
})

