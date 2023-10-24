local api = vim.api

api.nvim_command("autocmd TermOpen * startinsert")             -- starts in insert mode
api.nvim_command("autocmd TermOpen * setlocal nonumber")       -- no numbers
api.nvim_command("autocmd TermEnter * setlocal signcolumn=no") -- no sign column

vim.keymap.set('t', '<esc>', "<C-\\><C-n>")                    -- esc to exit insert



require("toggleterm").setup {

    shade_terminals = false

}



-- Hide the terminal when escape is hit.
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "term://*toggleterm#*",
  callback = function()
    if vim.o.filetype == "toggleterm" then
      vim.cmd('startinsert!')
    end
  end,
})
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*toggleterm#*",
  callback = function()
    if vim.o.filetype == "toggleterm" then
      -- Enter insert mode automatically
      vim.cmd('startinsert!')


      -- Map <Esc> in normal mode to close the terminal
      vim.api.nvim_buf_set_keymap(0, 'n', '<Esc>', ':ToggleTerm<CR>', { noremap = true, silent = true })
      
      -- Map <C-c> in insert mode to close the terminal
      vim.api.nvim_buf_set_keymap(0, 'i', '<C-c>', '<C-\\><C-n>:ToggleTerm<CR>', { noremap = true, silent = true })

    end
  end,
})

vim.api.nvim_set_keymap('n', '<leader>tf', '<cmd>ToggleTerm direction=float<CR>', { noremap = true, silent = true })

